import 'package:flutter/material.dart';

import 'levels_screen.dart';
import 'game_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "اختر اللعبة 🎮",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,

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
              "🧩\nالبازل",
              Colors.purple,
              null,
            ),

            gameButton(
              context,
              "🔤\nالحروف",
              Colors.red,
              null,
            ),

            gameButton(
              context,
              "🔢\nالأرقام",
              Colors.teal,
              null,
            ),

            gameButton(
              context,
              "🎨\nالألوان",
              Colors.pink,
              null,
            ),

            gameButton(
              context,
              "🐶\nالحيوانات",
              Colors.brown,
              null,
            ),

            gameButton(
              context,
              "🍎\nالفواكه",
              Colors.deepOrange,
              null,
            ),

            gameButton(
              context,
              "🎯\nالمطابقة",
              Colors.indigo,
              null,
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
              content: Text("هذه اللعبة ستضاف قريبًا 🚀"),
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