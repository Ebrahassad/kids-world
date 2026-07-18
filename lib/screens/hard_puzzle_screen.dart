import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';
import 'games_screen.dart';
import 'progress_manager.dart';

class HardPuzzleScreen extends StatefulWidget {
  const HardPuzzleScreen({super.key});

  @override
  State<HardPuzzleScreen> createState() =>
      _HardPuzzleScreenState();
}

class _HardPuzzleScreenState extends State<HardPuzzleScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  int stars = 0;
  bool loading = true;

  List<String> pieces = [

    "🐑",
    "🌈",
    "🌳",
    "🏡",
    "☀️",
    "🌸",

  ];

  final List<String> correctOrder = [

    "☀️",
    "🌈",
    "🌳",
    "🏡",
    "🌸",
    "🐑",

  ];

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {

    stars = await ProgressManager.getStars(
      "hard_puzzle",
    );

    setState(() {
      loading = false;
    });

  }

  void playSound(String fileName) {

    audioPlayer.play(
      AssetSource('sounds/$fileName'),
    );

  }
  Future<void> checkPuzzle() async {

    if (pieces.toString() == correctOrder.toString()) {

      playSound("correct.mp3");

      setState(() {
        stars++;
      });

      await ProgressManager.saveStars(
        "hard_puzzle",
        stars,
      );

      await ProgressManager.saveCompletedGame(
        "hard_puzzle",
      );

      Future.delayed(

        const Duration(milliseconds: 500),

        () async {

          if (!mounted) return;

          await ProgressManager.saveProgress(
            "hard_puzzle",
            0,
          );

          Navigator.pushReplacement(

            context,

            MaterialPageRoute(

              builder: (_) => WinScreen(

                stars: stars,

                nextGame:
                    const HardPuzzleScreen(),

                gamesPage:
                    const GamesScreen(),

              ),

            ),

          );

        },

      );

    } else {

      playSound("wrong.mp3");

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "رتب الصورة بشكل صحيح ⭐",
          ),

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

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(