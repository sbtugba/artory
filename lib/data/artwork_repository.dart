import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/artwork.dart';

class ArtworkRepository {
  Future<List<Artwork>> load() async {
    final source = await rootBundle.loadString('assets/data/artworks.json');
    return (jsonDecode(source) as List)
        .map((item) => Artwork.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
