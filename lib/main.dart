import 'package:flutter/material.dart';
import 'package:search_word_application/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grid View Word Search ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenPage(),
    );
  }
}
