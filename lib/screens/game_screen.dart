import 'package:flutter/material.dart';

import 'win_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "image": "assets/images/puzzles/kids_puzzle.png",
      "answer": "أطفال",
      "options": ["أطفال", "قرد", "أسد", "سمكة"],
    },
    {
      "image": "assets/images/puzzles/monkey_puzzle.png",
      "answer": "قرد",
      "options": ["دب", "قرد", "قطة", "كلب"],
    },
    {
      "image": "assets/images/puzzles/bear_puzzle.png",
      "answer": "دب",
      "options": ["سمكة", "دب", "أرنب", "أسد"],
    },
    {
      "image": "assets/images/puzzles/fish_puzzle.png",
      "answer": "سمكة",
      "options": ["فراشة", "سمكة", "كلب", "ديناصور"],
    },
    {
      "image": "assets/images/puzzles/dinosaur_puzzle.png",
      "answer": "ديناصور",
      "options": ["قرد", "ديناصور", "أسد", "دب"],
    },
    {
      "image": "assets/images/puzzles/butterfly_puzzle.png",
      "answer": "فراشة",
      "options": ["قطة", "كلب", "فراشة", "سمكة"],
    },
    {
      "image": "assets/images/puzzles/dog_puzzle.png",
      "answer": "كلب",
      "options": ["كلب", "أرنب", "دب", "أسد"],
    },
    {
      "image": "assets/images/puzzles/cat_puzzle.png",
      "answer": "قطة",
      "options": ["قطة", "سمكة", "قرد", "ديناصور"],
    },
    {
      "image": "assets/images/puzzles/rabbit_puzzle.png",
      "answer": "أرنب",
      "options": ["فراشة", "كلب", "أرنب", "أسد"],
    },
    {
      "image": "assets/images/puzzles/lion_puzzle.png",
      "answer": "أسد",
      "options": ["دب", "أسد", "قطة", "سمكة"],
    },
  ];

  int currentQuestion = 0;
  int stars = 0;

  void checkAnswer(String answer) {
  if (answer == questions[currentQuestion]["answer"]) {
    setState(() {
      stars++;
    });

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WinScreen(),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("حاول مرة أخرى ⭐"),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    final data = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المرحلة ${currentQuestion + 1} / ${questions.length}",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                data["image"],
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),
            ...List.generate(
              (data["options"] as List).length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        checkAnswer(data["options"][index]);
                      },
                      child: Text(
                        data["options"][index],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}