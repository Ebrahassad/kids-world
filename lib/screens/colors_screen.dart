import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';
import 'levels_screen.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({super.key});

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  int currentQuestion = 0;
  int stars = 0;

  final List<Map<String, dynamic>> questions = [

    {
      "question": "اختر اللون الأحمر",
      "answer": Colors.red,
      "options": [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
      ],
    },

    {
      "question": "اختر اللون الأزرق",
      "answer": Colors.blue,
      "options": [
        Colors.red,
        Colors.orange,
        Colors.blue,
        Colors.green,
      ],
    },

    {
      "question": "اختر اللون الأخضر",
      "answer": Colors.green,
      "options": [
        Colors.purple,
        Colors.green,
        Colors.red,
        Colors.yellow,
      ],
    },

    {
      "question": "اختر اللون الأصفر",
      "answer": Colors.yellow,
      "options": [
        Colors.blue,
        Colors.yellow,
        Colors.black,
        Colors.red,
      ],
    },

    {
      "question": "اختر اللون البرتقالي",
      "answer": Colors.orange,
      "options": [
        Colors.orange,
        Colors.green,
        Colors.purple,
        Colors.blue,
      ],
    },

    {
      "question": "اختر اللون البنفسجي",
      "answer": Colors.purple,
      "options": [
        Colors.yellow,
        Colors.red,
        Colors.purple,
        Colors.green,
      ],
    },
    {
      "question": "اختر اللون الأسود",
      "answer": Colors.black,
      "options": [
        Colors.black,
        Colors.white,
        Colors.red,
        Colors.blue,
      ],
    },

    {
      "question": "اختر اللون الأبيض",
      "answer": Colors.white,
      "options": [
        Colors.green,
        Colors.orange,
        Colors.white,
        Colors.purple,
      ],
    },

    {
      "question": "اختر اللون البني",
      "answer": Colors.brown,
      "options": [
        Colors.blue,
        Colors.brown,
        Colors.yellow,
        Colors.red,
      ],
    },

    {
      "question": "اختر اللون الوردي",
      "answer": Colors.pink,
      "options": [
        Colors.green,
        Colors.pink,
        Colors.orange,
        Colors.black,
      ],
    },

  ];

  void playSound(String fileName) {
    audioPlayer.play(
      AssetSource('sounds/$fileName'),
    );
  }

  void checkAnswer(Color color) {
    if (color == questions[currentQuestion]["answer"]) {

      playSound("correct.mp3");

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
    builder: (_) => WinScreen(
      stars: stars,
      nextGame: const ColorsScreen(),
      gamesPage: const LevelsScreen(),
    ),
  ),
);
      }

    } else {

      playSound("wrong.mp3");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("حاول مرة أخرى ⭐"),
        ),
      );

    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final data = questions[currentQuestion];

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "تعلم الألوان ${currentQuestion + 1}/${questions.length}",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                const SizedBox(width: 5),
                Text(
                  "$stars",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            Text(
              data["question"],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.builder(
                itemCount: (data["options"] as List).length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {

                  final Color color = data["options"][index] as Color;

                  return GestureDetector(
                    onTap: () {
                      checkAnswer(color);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
        
    );
  }
}