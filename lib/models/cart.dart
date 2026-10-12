import 'package:flutter/foundation.dart';

import 'artwork.dart';

/// Stores cart quantities for the current application session.
class Cart extends ChangeNotifier {
  final Map<String, int> _quantities = {};

  Set<String> get productIds => Set.unmodifiable(_quantities.keys);

  int get itemCount => _quantities.values.fold(0, (sum, value) => sum + value);

  int quantityOf(Artwork artwork) => _quantities[artwork.id] ?? 0;

  List<Artwork> itemsFrom(List<Artwork> artworks) =>
      artworks.where((artwork) => quantityOf(artwork) > 0).toList();

  int totalPrice(List<Artwork> artworks) => artworks.fold(
        0,
        (sum, artwork) => sum + artwork.price * quantityOf(artwork),
      );

  void add(Artwork artwork) => setQuantity(artwork, quantityOf(artwork) + 1);

  void setQuantity(Artwork artwork, int quantity) {
    final nextQuantity = quantity < 0 ? 0 : quantity;
    if (quantityOf(artwork) == nextQuantity) return;
    if (nextQuantity == 0) {
      _quantities.remove(artwork.id);
    } else {
      _quantities[artwork.id] = nextQuantity;
    }
    notifyListeners();
  }
}
