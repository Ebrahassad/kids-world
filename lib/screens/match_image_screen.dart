import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';

class MatchImageScreen extends StatefulWidget {
  const MatchImageScreen({super.key});

  @override
  State<MatchImageScreen> createState() => _MatchImageScreenState();
}

class _MatchImageScreenState extends State<MatchImageScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  int currentQuestion = 0;
  int stars = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "image": "assets/images/Puzzle/kids_puzzle.png",
      "answer": "assets/images/Puzzle/kids_puzzle.png",
      "options": [
        "assets/images/Puzzle/kids_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/monkey_puzzle.png",
      "answer": "assets/images/Puzzle/monkey_puzzle.png",
      "options": [
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/monkey_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/rabbit_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/bear_puzzle.png",
      "answer": "assets/images/Puzzle/bear_puzzle.png",
      "options": [
        "assets/images/Puzzle/lion_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/dinosaur_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/fish_puzzle.png",
      "answer": "assets/images/Puzzle/fish_puzzle.png",
      "options": [
        "assets/images/Puzzle/butterfly_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/dog_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/dinosaur_puzzle.png",
      "answer": "assets/images/Puzzle/dinosaur_puzzle.png",
      "options": [
        "assets/images/Puzzle/rabbit_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
        "assets/images/Puzzle/dinosaur_puzzle.png",
        "assets/images/Puzzle/monkey_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/butterfly_puzzle.png",
      "answer": "assets/images/Puzzle/butterfly_puzzle.png",
      "options": [
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/butterfly_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/kids_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/dog_puzzle.png",
      "answer": "assets/images/Puzzle/dog_puzzle.png",
      "options": [
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/cat_puzzle.png",
      "answer": "assets/images/Puzzle/cat_puzzle.png",
      "options": [
        "assets/images/Puzzle/rabbit_puzzle.png",
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/cat_puzzle.png",
        "assets/images/Puzzle/monkey_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/rabbit_puzzle.png",
      "answer": "assets/images/Puzzle/rabbit_puzzle.png",
      "options": [
        "assets/images/Puzzle/fish_puzzle.png",
        "assets/images/Puzzle/rabbit_puzzle.png",
        "assets/images/Puzzle/dinosaur_puzzle.png",
        "assets/images/Puzzle/butterfly_puzzle.png",
      ],
    },
    {
      "image": "assets/images/Puzzle/lion_puzzle.png",
      "answer": "assets/images/Puzzle/lion_puzzle.png",
      "options": [
        "assets/images/Puzzle/bear_puzzle.png",
        "assets/images/Puzzle/dog_puzzle.png",
        "assets/images/Puzzle/lion_puzzle.png",
        "assets/images/Puzzle/kids_puzzle.png",
      ],
    },
  ];

  void playSound(String fileName) {
    audioPlayer.play(AssetSource('sounds/$fileName'));
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
            builder: (_) => const WinScreen(),
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
          "مطابقة الصور ${currentQuestion + 1}/${questions.length}",
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 10),

            const Text(
              "اختر الصورة المطابقة",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              flex: 2,
              child: Image.asset(
                data["image"],
                fit: BoxFit.contain,
              ),
            ),

            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: data["options"].length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      checkAnswer(data["options"][index]);
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          data["options"][index],
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
      ),
    );
  }
}