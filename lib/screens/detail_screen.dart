import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/artwork.dart';
import '../models/cart.dart';
import '../widgets/artwork_image.dart';

class DetailScreen extends StatelessWidget {
  final Artwork artwork;
  final Cart cart;

  const DetailScreen({super.key, required this.artwork, required this.cart});

  @override
  Widget build(BuildContext context) {
    final a = artwork;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 652),
              child: SizedBox(
                height: 62,
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: olive),
                  onPressed: () => cart.add(artwork),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text(
                    'Sepete Ekle',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .44,
                      child: ArtworkImage(artwork: a),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: IconButton.filled(
                          tooltip: 'Geri',
                          style: IconButton.styleFrom(
                            backgroundColor: paper,
                            foregroundColor: olive,
                          ),
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${a.title} — Poster',
                        style: const TextStyle(
                          fontFamily: 'ArtorySerif',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${a.artist} · ${a.year}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${a.price} ₺',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: olive,
                        ),
                      ),
                      const Text('30 × 40 cm · Sanat baskısı · Çerçevesiz'),
                      ListenableBuilder(
                        listenable: cart,
                        builder: (context, _) {
                          final quantity = cart.quantityOf(artwork);
                          if (quantity == 0) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Sepette $quantity adet',
                              style: const TextStyle(color: olive),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Chip(label: Text(a.period)),
                      const SizedBox(height: 20),
                      const Text(
                        'Eserin Hikâyesi',
                        style: TextStyle(
                          fontFamily: 'ArtorySerif',
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        a.story,
                        style: const TextStyle(fontSize: 17, height: 1.6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
