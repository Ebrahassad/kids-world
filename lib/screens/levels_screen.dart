import 'package:flutter/material.dart';
import 'memory_screen.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "مستويات لعبة الذاكرة 🧠",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "اختر المستوى ⭐",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            levelButton(
              context,
              "المستوى الأول ⭐",
              Colors.green,
            ),

            const SizedBox(height: 20),

            levelButton(
              context,
              "المستوى الثاني ⭐⭐",
              Colors.orange,
            ),

            const SizedBox(height: 20),

            levelButton(
              context,
              "المستوى الثالث ⭐⭐⭐",
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget levelButton(
    BuildContext context,
    String text,
    Color color,
  ) {
    return SizedBox(
      width: 280,
      height: 65,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MemoryGameScreen(),
            ),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}