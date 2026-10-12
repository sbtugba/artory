import 'package:flutter/material.dart';

import '../models/artwork.dart';

class ArtworkImage extends StatelessWidget {
  final Artwork artwork;
  const ArtworkImage({super.key, required this.artwork});
  @override
  Widget build(BuildContext context) => Image.asset(
        artwork.image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, error, stack) => const ColoredBox(
          color: Color(0xFFE8E4D9),
          child: Center(child: Icon(Icons.image_outlined, size: 40)),
        ),
      );
}
