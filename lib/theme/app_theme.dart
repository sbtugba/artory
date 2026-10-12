import 'package:flutter/material.dart';

const olive = Color(0xFF38432D);
const paper = Color(0xFFFAF7F1);
const muted = Color(0xFF82776E);

final appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'ArtorySans',
  scaffoldBackgroundColor: paper,
  colorScheme: ColorScheme.fromSeed(seedColor: olive, surface: paper),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: muted, fontSize: 16),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: paper,
    foregroundColor: olive,
  ),
);
