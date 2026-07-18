import 'package:flutter/material.dart';

import 'memory_levels_screen.dart';
import 'game_screen.dart';
import 'choose_image_screen.dart';
import 'letters_screen.dart';
import 'numbers_screen.dart';
import 'colors_screen.dart';
import 'match_image_screen.dart';
import 'puzzle_order_screen.dart';
import 'hard_puzzle_screen.dart';
import 'sort_objects_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "اختر اللعبة 🎮",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1,
          children: [

            // 1
            gameButton(
              context,
              "🖼️\nالتعرف على الصورة",
              Colors.orange,
              const GameScreen(),
            ),

            // 2
            gameButton(
              context,
              "📸\nاختر الصورة",
              Colors.amber,
              const ChooseImageScreen(),
            ),

            // 3
            gameButton(
              context,
              "🎯\nمطابقة الصور",
              Colors.indigo,
              const MatchImageScreen(),
            ),

            // 4
            gameButton(
              context,
              "🎨\nالألوان",
              Colors.pink,
              const ColorsScreen(),
            ),

            // 5
            gameButton(
              context,
              "🔢\nالأرقام",
              Colors.teal,
              const NumbersScreen(),
            ),

            // 6
            gameButton(
              context,
              "🔤\nالحروف",
              Colors.red,
              const LettersScreen(),
            ),

            // 7
            gameButton(
  context,
  "🧠\nلعبة الذاكرة",
  Colors.green,
  const MemoryLevelsScreen(),
),

            // 8
            gameButton(
              context,
              "🍎\nترتيب الأشياء",
              Colors.deepOrange,
              const SortObjectsScreen(),
            ),

            // 9
            gameButton(
              context,
              "🧩\nترتيب الصورة",
              Colors.purple,
              const PuzzleOrderScreen(),
            ),

            // 10
            gameButton(
              context,
              "⭐\nالبازل الصعب",
              Colors.deepPurple,
              const HardPuzzleScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameButton(
    BuildContext context,
    String title,
    Color color,
    Widget page,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}