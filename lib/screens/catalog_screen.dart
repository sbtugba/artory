import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/artwork.dart';
import '../widgets/artwork_image.dart';

class CatalogScreen extends StatefulWidget {
  final List<Artwork> artworks;
  final Set<String> cartIds;
  final ValueChanged<Artwork> onAdd, onOpen;
  const CatalogScreen({
    super.key,
    required this.artworks,
    required this.cartIds,
    required this.onAdd,
    required this.onOpen,
  });
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _query = '', _period = 'Tümü';
  String _normalize(String text) =>
      text.replaceAll('İ', 'i').toLowerCase().replaceAll('ı', 'i');
  @override
  Widget build(BuildContext context) {
    final query = _normalize(_query.trim());
    final visible = widget.artworks
        .where(
          (a) =>
              (_period == 'Tümü' ||
                  a.period == _period ||
                  (_period == 'Empresyonizm' &&
                      a.period == 'Post-Empresyonizm')) &&
              _normalize('${a.title} ${a.artist}').contains(query),
        )
        .toList();
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 18),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Artory',
                  style: const TextStyle(
                    fontFamily: 'ArtorySerif',
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF171B13),
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sanat baskılarını keşfet, hikâyelerini öğren',
                  style: const TextStyle(fontSize: 17, color: muted),
                ),
                const SizedBox(height: 24),
                TextField(
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Eser veya sanatçı ara',
                    prefixIcon: const Icon(Icons.search, color: olive),
                    filled: true,
                    fillColor: const Color(0xFFF0ECE4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      'Tümü',
                      'Rönesans',
                      'Empresyonizm',
                      'Modern',
                      'Barok',
                      'Ukiyo-e',
                    ]
                        .map(
                          (period) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(period),
                              selected: _period == period,
                              showCheckmark: false,
                              selectedColor: olive,
                              backgroundColor: const Color(0xFFF0ECE4),
                              side: BorderSide.none,
                              labelStyle: TextStyle(
                                color: _period == period ? Colors.white : muted,
                              ),
                              onSelected: (_) =>
                                  setState(() => _period = period),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (visible.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48, color: olive),
                  const SizedBox(height: 16),
                  Text(
                    'Ürün bulunamadı',
                    style: const TextStyle(fontSize: 22, color: olive),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Başka bir eser, sanatçı veya dönem dene.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        if (visible.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverLayoutBuilder(
              builder: (_, constraints) => SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.crossAxisExtent > 650 ? 4 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 14,
                  mainAxisExtent: 306,
                ),
                itemCount: visible.length,
                itemBuilder: (_, index) {
                  final a = visible[index];
                  final selected = widget.cartIds.contains(a.id);
                  return Material(
                    color: const Color(0xFFFFFCF7),
                    borderRadius: BorderRadius.circular(18),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => widget.onOpen(a),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: ArtworkImage(artwork: a),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 2, 9),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        a.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        a.artist,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      Text(
                                        '${a.price} ₺ · Poster',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Sepete ekle',
                                  constraints: const BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 44,
                                  ),
                                  padding: EdgeInsets.zero,
                                  onPressed: () => widget.onAdd(a),
                                  icon: Icon(
                                    Icons.add_shopping_cart,
                                    color: selected
                                        ? olive
                                        : const Color(0xFF876B53),
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
