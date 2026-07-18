import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';
import 'games_screen.dart';
import 'progress_manager.dart';

class LettersScreen extends StatefulWidget {
  const LettersScreen({super.key});

  @override
  State<LettersScreen> createState() =>
      _LettersScreenState();
}

class _LettersScreenState extends State<LettersScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  int currentQuestion = 0;
  int stars = 0;
  bool loading = true;

  final List<Map<String, dynamic>> questions = [

    // اترك قائمة questions كما هي بدون أي تعديل

  ];

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {

    currentQuestion =
        await ProgressManager.getProgress(
      "letters_game",
    );

    stars =
        await ProgressManager.getStars(
      "letters_game",
    );

    setState(() {
      loading = false;
    });

  }

  void playSound(String fileName) {

    audioPlayer.play(
      AssetSource(
        'sounds/$fileName',
      ),
    );

  }
Future<void> checkAnswer(String answer) async {

  if (answer == questions[currentQuestion]["answer"]) {

    playSound("correct.mp3");

    setState(() {
      stars++;
    });

    await ProgressManager.saveStars(
      "letters_game",
      stars,
    );

    if (currentQuestion < questions.length - 1) {

      setState(() {
        currentQuestion++;
      });

      await ProgressManager.saveProgress(
        "letters_game",
        currentQuestion,
      );

    } else {

      await ProgressManager.saveCompletedGame(
        "letters_game",
      );

      await ProgressManager.saveProgress(
        "letters_game",
        0,
      );

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) => WinScreen(

            stars: stars,

            nextGame:
                const LettersScreen(),

            gamesPage:
                const GamesScreen(),

          ),

        ),

      );

    }

  } else {

    playSound("wrong.mp3");

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "حاول مرة أخرى ⭐",
        ),

      ),

    );

  }

}
  @override
  Widget build(BuildContext context) {

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final data = questions[currentQuestion];