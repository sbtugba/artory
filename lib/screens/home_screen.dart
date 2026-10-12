import 'package:flutter/material.dart';

import '../data/artwork_repository.dart';
import '../models/artwork.dart';
import '../models/cart.dart';
import '../theme/app_theme.dart';
import 'catalog_screen.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

class ArtoryHome extends StatefulWidget {
  const ArtoryHome({super.key});
  @override
  State<ArtoryHome> createState() => _ArtoryHomeState();
}

class _ArtoryHomeState extends State<ArtoryHome> {
  late Future<List<Artwork>> _artworks;
  final Cart _cart = Cart();
  int _tab = 0;
  @override
  void initState() {
    super.initState();
    _artworks = ArtworkRepository().load();
  }

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  Future<void> _open(Artwork artwork) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        settings: RouteSettings(name: '/artwork', arguments: artwork),
        builder: (_) => DetailScreen(artwork: artwork, cart: _cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: ListenableBuilder(
                listenable: _cart,
                builder: (context, _) => FutureBuilder<List<Artwork>>(
                  future: _artworks,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Eserler yüklenemedi.'),
                            TextButton(
                              onPressed: () => setState(() {
                                _artworks = ArtworkRepository().load();
                              }),
                              child: const Text('Tekrar dene'),
                            ),
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (_tab == 1) {
                      return CartScreen(
                        artworks: snapshot.data!,
                        cart: _cart,
                        onOpen: _open,
                      );
                    }
                    return CatalogScreen(
                      artworks: snapshot.data!,
                      cartIds: _cart.productIds,
                      onAdd: _cart.add,
                      onOpen: _open,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: paper,
          indicatorColor: const Color(0xFFE8E9DD),
          selectedIndex: _tab,
          onDestinationSelected: (value) => setState(() => _tab = value),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: olive),
              label: 'Keşfet',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              selectedIcon: Icon(Icons.shopping_bag, color: olive),
              label: 'Sepet',
            ),
          ],
        ),
      );
}
