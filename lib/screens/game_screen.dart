import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> images = [
    'assets/images/puzzles/kids_puzzle.png',
    'assets/images/puzzles/monkey_puzzle.png',
    'assets/images/puzzles/bear_puzzle.png',
    'assets/images/puzzles/fish_puzzle.png',
    'assets/images/puzzles/dinosaur_puzzle.png',
    'assets/images/puzzles/butterfly_puzzle.png',
    'assets/images/puzzles/dog_puzzle.png',
    'assets/images/puzzles/cat_puzzle.png',
    'assets/images/puzzles/rabbit_puzzle.png',
    'assets/images/puzzles/lion_puzzle.png',
  ];

  String currentImage = '';

  @override
  void initState() {
    super.initState();
    changeImage();
  }

  void changeImage() {
    setState(() {
      currentImage = images[Random().nextInt(images.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'اختر القطع لتكوين الصورة',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Image.asset(
            currentImage,
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: changeImage,
            child: const Text('صورة جديدة'),
          ),
        ],
      ),
    );
  }
}