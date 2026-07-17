import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';
import 'games_screen.dart';

class LettersScreen extends StatefulWidget {
  const LettersScreen({super.key});

  @override
  State<LettersScreen> createState() => _LettersScreenState();
}

class _LettersScreenState extends State<LettersScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  int currentQuestion = 0;
  int stars = 0;

  final List<Map<String, dynamic>> questions = [

    {
      "question": "أ",
      "answer": "أ",
      "options": ["أ", "ب", "ت", "ث"],
    },

    {
      "question": "ب",
      "answer": "ب",
      "options": ["ج", "ب", "خ", "د"],
    },

    {
      "question": "ت",
      "answer": "ت",
      "options": ["ت", "ث", "ج", "ح"],
    },

    {
      "question": "ث",
      "answer": "ث",
      "options": ["خ", "د", "ث", "ذ"],
    },

    {
      "question": "ج",
      "answer": "ج",
      "options": ["ر", "ز", "ج", "س"],
    },

    {
      "question": "ح",
      "answer": "ح",
      "options": ["ش", "ص", "ح", "ض"],
    },

    {
      "question": "خ",
      "answer": "خ",
      "options": ["خ", "د", "ذ", "ر"],
    },

    {
      "question": "د",
      "answer": "د",
      "options": ["ز", "د", "ر", "س"],
    },

    {
      "question": "ر",
      "answer": "ر",
      "options": ["ر", "ز", "ش", "ص"],
    },

    {
      "question": "ز",
      "answer": "ز",
      "options": ["ز", "س", "ش", "ض"],
    },
    {
      "question": "س",
      "answer": "س",
      "options": ["س", "ش", "ص", "ض"],
    },

    {
      "question": "ش",
      "answer": "ش",
      "options": ["ش", "س", "ط", "ظ"],
    },

    {
      "question": "ص",
      "answer": "ص",
      "options": ["ض", "ص", "ط", "ع"],
    },

    {
      "question": "ض",
      "answer": "ض",
      "options": ["س", "ش", "ض", "ص"],
    },

    {
      "question": "ط",
      "answer": "ط",
      "options": ["ض", "ط", "ظ", "ع"],
    },

    {
      "question": "ظ",
      "answer": "ظ",
      "options": ["غ", "ف", "ظ", "ق"],
    },

    {
      "question": "ع",
      "answer": "ع",
      "options": ["ك", "ل", "ع", "م"],
    },

    {
      "question": "غ",
      "answer": "غ",
      "options": ["ن", "هـ", "غ", "و"],
    },

    {
      "question": "ف",
      "answer": "ف",
      "options": ["ي", "أ", "ف", "ب"],
    },

    {
      "question": "ق",
      "answer": "ق",
      "options": ["ت", "ث", "ق", "ج"],
    },

    {
      "question": "ك",
      "answer": "ك",
      "options": ["ح", "خ", "ك", "د"],
    },
    {
      "question": "ل",
      "answer": "ل",
      "options": ["ذ", "ر", "ل", "ز"],
    },

    {
      "question": "م",
      "answer": "م",
      "options": ["س", "ش", "م", "ص"],
    },

    {
      "question": "ن",
      "answer": "ن",
      "options": ["ض", "ط", "ن", "ظ"],
    },

    {
      "question": "هـ",
      "answer": "هـ",
      "options": ["ع", "غ", "هـ", "ف"],
    },

    {
      "question": "و",
      "answer": "و",
      "options": ["ق", "ك", "و", "ل"],
    },

    {
      "question": "ي",
      "answer": "ي",
      "options": ["م", "ن", "ي", "هـ"],
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

      else {

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => WinScreen(
        stars: stars + 1,
        nextGame: const LettersScreen(),
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
          "تعلم الحروف ${currentQuestion + 1}/${questions.length}",
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
              "اختر الحرف الصحيح",
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


                  String letter =
                      data["options"][index];


                  return ElevatedButton(

                    onPressed: () {

                      checkAnswer(letter);

                    },


                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.green,

                      shape: RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(20),

                      ),

                    ),


                    child: Text(

                      letter,

                      style: const TextStyle(

                        fontSize: 45,

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