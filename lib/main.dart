import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const ArtoryApp());

class ArtoryApp extends StatelessWidget {
  const ArtoryApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Artory',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const ArtoryHome(),
      );
}
