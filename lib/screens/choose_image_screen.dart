import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';
import 'games_screen.dart';
import 'progress_manager.dart';

class ChooseImageScreen extends StatefulWidget {
  const ChooseImageScreen({super.key});

  @override
  State<ChooseImageScreen> createState() =>
      _ChooseImageScreenState();
}

class _ChooseImageScreenState extends State<ChooseImageScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  int currentQuestion = 0;
  int stars = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "أين الأطفال؟ 🧒",
      "answer": "assets/images/Puzzle/kids_puzzle.png",
      "options": [
        "assets/images/Puzzle/kids_puzzle.png",
        "assets/images/Puzzle/monkey_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
      ],
    },
    {
      "question": "أين القرد؟ 🐒",
      "answer": "assets/images/Puzzle/monkey_puzzle.png",
      "options": [
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/monkey_puzzle.png",
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
      ],
    },
    {
      "question": "أين الدب؟ 🐻",
      "answer": "assets/images/Puzzle/bear_puzzle.png",
      "options": [
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/rabbit_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/butterfly_puzzle.png",
      ],
    },
    {
      "question": "أين السمكة؟ 🐟",
      "answer": "assets/images/Puzzle/fish_puzzle.png",
      "options": [
        "assets/images/Puzzle/lion_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/dinosaur_puzzle.png",
        "assets/images/Puzzle/cat_puzzle.png",
      ],
    },
    {
      "question": "أين الديناصور؟ 🦖",
      "answer": "assets/images/Puzzle/dinosaur_puzzle.png",
      "options": [
        "assets/images/Puzzle/dinosaur_puzzle.png",
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/monkey_puzzle.png",
      ],
    },
    {
      "question": "أين الفراشة؟ 🦋",
      "answer": "assets/images/Puzzle/butterfly_puzzle.png",
      "options": [
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/butterfly_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/rabbit_puzzle.png",
      ],
    },
    {
      "question": "أين الكلب؟ 🐶",
      "answer": "assets/images/Puzzle/dog_puzzle.png",
      "options": [
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
        "assets/images/Puzzle/butterfly_puzzle.png",
        "assets/images/Puzzle/kids_puzzle.png",
      ],
    },
    {
      "question": "أين القطة؟ 🐱",
      "answer": "assets/images/Puzzle/cat_puzzle.png",
      "options": [
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/dinosaur_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
      ],
    },
    {
      "question": "أين الأرنب؟ 🐰",
      "answer": "assets/images/Puzzle/rabbit_puzzle.png",
      "options": [
        "assets/images/Puzzle/rabbit_puzzle.png",
        "assets/images/Puzzle/monkey_puzzle.png",
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
      ],
    },
    {
      "question": "أين الأسد؟ 🦁",
      "answer": "assets/images/Puzzle/lion_puzzle.png",
      "options": [
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
      ],
    },
  ];
  void playSound(String fileName) {
    audioPlayer.play(
      AssetSource('sounds/$fileName'),
    );
  }

  void checkAnswer(String image) {
    if (image == questions[currentQuestion]["answer"]) {
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
      stars: stars + 1,
      nextGame: const ChooseImageScreen(),
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
          "اختيار الصورة ${currentQuestion + 1}/${questions.length}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
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
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 25),

          Text(
            data["question"],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: data["options"].length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                final String image = data["options"][index];

                return GestureDetector(
                  onTap: () {
                    checkAnswer(image);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}