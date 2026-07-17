import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';
import 'games_screen.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  int currentQuestion = 0;
  int stars = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "1",
      "answer": "1",
      "options": ["1", "3", "5", "8"],
    },
    {
      "question": "2",
      "answer": "2",
      "options": ["4", "2", "6", "9"],
    },
    {
      "question": "3",
      "answer": "3",
      "options": ["7", "1", "3", "5"],
    },
    {
      "question": "4",
      "answer": "4",
      "options": ["4", "2", "8", "6"],
    },
    {
      "question": "5",
      "answer": "5",
      "options": ["1", "5", "3", "9"],
    },
    {
      "question": "6",
      "answer": "6",
      "options": ["2", "8", "6", "4"],
    },
    {
      "question": "7",
      "answer": "7",
      "options": ["7", "5", "1", "3"],
    },
    {
      "question": "8",
      "answer": "8",
      "options": ["6", "2", "8", "4"],
    },
    {
      "question": "9",
      "answer": "9",
      "options": ["3", "7", "9", "5"],
    },
    {
      "question": "10",
      "answer": "10",
      "options": ["8", "10", "4", "2"],
    },
  ];

  void playSound(String fileName) {
    audioPlayer.play(
      AssetSource('sounds/$fileName'),
    );
  }

  void checkAnswer(String answer) {
    if (answer == questions[currentQuestion]["answer"]) {
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
      nextGame: const NumbersScreen(),
      gamesPage: const GamesScreen(),
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
          "تعلم الأرقام ${currentQuestion + 1}/${questions.length}",
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

            const Text(
              "اختر الرقم الصحيح",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              data["question"],
              style: const TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
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
      final String number =
          data["options"][index] as String;

      return ElevatedButton(
        onPressed: () {
          checkAnswer(number);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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