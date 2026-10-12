import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/artwork.dart';
import '../models/cart.dart';
import '../widgets/artwork_image.dart';

class CartScreen extends StatelessWidget {
  final List<Artwork> artworks;
  final Cart cart;
  final ValueChanged<Artwork> onOpen;
  const CartScreen({
    super.key,
    required this.artworks,
    required this.cart,
    required this.onOpen,
  });
  @override
  Widget build(BuildContext context) {
    final items = cart.itemsFrom(artworks);
    final count = cart.itemCount;
    final total = cart.totalPrice(artworks);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sepetim',
                style: TextStyle(
                  fontFamily: 'ArtorySerif',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: olive,
                ),
              ),
              const SizedBox(height: 8),
              Text('$count ürün'),
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 48, color: olive),
                      SizedBox(height: 16),
                      Text(
                        'Sepetin henüz boş',
                        style: TextStyle(fontSize: 22, color: olive),
                      ),
                      SizedBox(height: 8),
                      Text('Keşfet’ten sevdiğin sanat baskılarını ekle.'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final a = items[index];
                    final quantity = cart.quantityOf(a);
                    return Card(
                      color: const Color(0xFFFFFCF7),
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => onOpen(a),
                              child: SizedBox(
                                width: 90,
                                height: 130,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: ArtworkImage(artwork: a),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${a.title} — Poster',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: olive,
                                    ),
                                  ),
                                  Text(
                                    a.artist,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${a.price * quantity} ₺',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: olive,
                                    ),
                                  ),
                                  Text(
                                    '${a.price} ₺ / adet',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        tooltip: 'Adet azalt',
                                        onPressed: () =>
                                            cart.setQuantity(a, quantity - 1),
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                        ),
                                      ),
                                      Text(
                                        '$quantity',
                                        key: ValueKey('quantity-${a.id}'),
                                      ),
                                      IconButton(
                                        tooltip: 'Adet artır',
                                        onPressed: () =>
                                            cart.setQuantity(a, quantity + 1),
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              tooltip: 'Sepetten çıkar',
                              onPressed: () => cart.setQuantity(a, 0),
                              icon: const Icon(Icons.delete_outline, size: 22),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Toplam',
                      style: TextStyle(fontSize: 20, color: olive),
                    ),
                    Text(
                      '$total ₺',
                      key: const ValueKey('cart-total'),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: olive,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Eğitim amaçlı sepet simülasyonu. Ödeme alınmaz.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
