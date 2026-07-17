import 'package:flutter/material.dart';

import 'levels_screen.dart';
import 'game_screen.dart';
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

            gameButton(
              context,
              "🧠\nلعبة الذاكرة",
              Colors.green,
              const LevelsScreen(),
            ),

            gameButton(
              context,
              "🖼️\nالتعرف على الصورة",
              Colors.orange,
              const GameScreen(),
            ),

            gameButton(
              context,
              "🔤\nتعلم الحروف",
              Colors.red,
              const LettersScreen(),
            ),

            gameButton(
              context,
              "🔢\nتعلم الأرقام",
              Colors.teal,
              const NumbersScreen(),
            ),

            gameButton(
              context,
              "🎨\nتعلم الألوان",
              Colors.pink,
              const ColorsScreen(),
            ),

            gameButton(
              context,
              "🖼️\nمطابقة الصور",
              Colors.indigo,
              const MatchImageScreen(),
            ),

            gameButton(
              context,
              "🧩\nترتيب الصورة",
              Colors.purple,
              const PuzzleOrderScreen(),
            ),

            gameButton(
              context,
              "🧩\nالبازل الصعب",
              Colors.deepPurple,
              const HardPuzzleScreen(),
            ),

            gameButton(
              context,
              "🍎\nترتيب الأشياء",
              Colors.deepOrange,
              const SortObjectsScreen(),
            ),

            gameButton(
              context,
              "🔊\nالأصوات",
              Colors.cyan,
              null,
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
    Widget? page,
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
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "هذه اللعبة ستضاف قريبًا 🚀",
              ),
            ),
          );
        }
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