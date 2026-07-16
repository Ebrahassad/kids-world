import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class KidsWorldApp extends StatelessWidget {
  const KidsWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids World',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}