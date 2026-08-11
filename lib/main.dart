import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const GramaSevaApp());
}

class GramaSevaApp extends StatelessWidget {
  const GramaSevaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grama Cart',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily:
            'Roboto', // Make sure to configure fonts in pubspec.yaml if customized
      ),
      home: const SplashScreen(),
    );
  }
}
