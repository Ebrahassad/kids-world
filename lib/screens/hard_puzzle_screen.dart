import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../progress_manager.dart';
import 'games_screen.dart';
import 'win_screen.dart';

class HardPuzzleScreen extends StatefulWidget {
  const HardPuzzleScreen({super.key});

  @override
  State<HardPuzzleScreen> createState() =>
      _HardPuzzleScreenState();
}

class _HardPuzzleScreenState
    extends State<HardPuzzleScreen> {

  static const String gameName =
      "hard_puzzle";

  final AudioPlayer audioPlayer =
      AudioPlayer();

  final Random random =
      Random();

  bool loading = true;

  bool answering = false;

  int stars = 0;

  late List<String> pieces;

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

    preparePuzzle();

    loadProgress();

  }

  void preparePuzzle() {

    pieces = List<String>.from(
      correctOrder,
    );

    pieces.shuffle(
      random,
    );

  }
  Future<void> loadProgress() async {

    stars = await ProgressManager.getStars(
      gameName,
    );

    if (mounted) {

      setState(() {

        loading = false;

      });

    }

  }

  Future<void> playSound(
    String fileName,
  ) async {

    try {

      await audioPlayer.stop();

      await audioPlayer.play(

        AssetSource(
          "sounds/$fileName",
        ),

      );

    } catch (e) {

      debugPrint(
        "خطأ تشغيل الصوت: $e",
      );

    }

  }

  Future<void> checkPuzzle() async {

    if (answering) return;

    answering = true;

    if (pieces.join() == correctOrder.join()) {

      await playSound(
        "correct.mp3",
      );

      setState(() {

        stars++;

      });

      await ProgressManager.saveStars(
        gameName,
        stars,
      );

      await ProgressManager.saveCompletedGame(
        gameName,
      );

      await ProgressManager.saveProgress(
        gameName,
        0,
      );

      await playSound(
        "win.mp3",
      );

      if (!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) => WinScreen(

            stars: stars,
gameId: 10,
            nextGame:
                const HardPuzzleScreen(),

            gamesPage:
                const GamesScreen(),

          ),

        ),

      );

    } else {

      await playSound(
        "wrong.mp3",
      );

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "❌ الترتيب غير صحيح، حاول مرة أخرى",
          ),

          backgroundColor: Colors.red,

          duration: Duration(
            milliseconds: 900,
          ),

        ),

      );

      answering = false;

    }

  }
  void restartGame() {

    audioPlayer.stop();

    preparePuzzle();

    setState(() {

      stars = 0;

      answering = false;

    });

    ProgressManager.resetProgress(
      gameName,
    );

  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Scaffold(

        body: Center(

          child:
              CircularProgressIndicator(),

        ),

      );

    }

    return Scaffold(

      body: Container(

        width: double.infinity,

        height: double.infinity,

        decoration: const BoxDecoration(

          image: DecorationImage(

            image: AssetImage(
              "assets/images/background.png",
            ),

            fit: BoxFit.cover,

          ),

        ),

        child: Container(

          color: Colors.white.withOpacity(0.25),

          child: SafeArea(

            child: Column(

              children: [

                const SizedBox(
                  height: 20,
                ),

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,

                  children: [

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 20,

                        vertical: 10,

                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                      ),

                      child: Text(

                        "⭐ $stars",

                        style: const TextStyle(

                          fontSize: 24,

                          fontWeight: FontWeight.bold,

                          color: Colors.orange,

                        ),

                      ),

                    ),

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 20,

                        vertical: 10,

                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                      ),

                      child: const Text(

                        "رتب الصورة 🧩",

                        style: TextStyle(

                          fontSize: 22,

                          fontWeight: FontWeight.bold,

                        ),

                      ),

                    ),

                  ],

                ),

                const SizedBox(
                  height: 25,
                ),

                const Text(

                  "اسحب القطع إلى الترتيب الصحيح",

                  style: TextStyle(

                    fontSize: 26,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                const SizedBox(
                  height: 20,
                ),

                Expanded(

                  child: ReorderableListView(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 25,

                    ),

                    onReorder:
                        (oldIndex, newIndex) {
                      setState(() {

                        if (newIndex > oldIndex) {

                          newIndex--;

                        }

                        final item =
                            pieces.removeAt(
                              oldIndex,
                            );

                        pieces.insert(
                          newIndex,
                          item,
                        );

                      });

                    },

                    children: List.generate(

                      pieces.length,

                      (index) {

                        return Card(

                          key: ValueKey(
                            pieces[index],
                          ),

                          elevation: 6,

                          margin:
                              const EdgeInsets.symmetric(
                            vertical: 8,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),

                          ),

                          child: ListTile(

                            leading: const Icon(

                              Icons.drag_handle,

                              color: Colors.blue,

                            ),

                            title: Center(

                              child: Text(

                                pieces[index],

                                style:
                                    const TextStyle(

                                  fontSize: 50,

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),

                            ),

                          ),

                        );

                      },

                    ),

                  ),

                ),

                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(

                  onPressed:
                      answering
                          ? null
                          : checkPuzzle,

                  icon: const Icon(
                    Icons.check_circle,
                  ),

                  label: const Text(

                    "تحقق من الترتيب",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.green,

                    foregroundColor:
                        Colors.white,

                    elevation: 8,

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 35,

                      vertical: 12,

                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        25,
                      ),

                    ),

                  ),

                ),

                const SizedBox(
                  height: 15,
                ),

                ElevatedButton.icon(

                  onPressed:
                      answering
                          ? null
                          : restartGame,

                  icon: const Icon(
                    Icons.refresh,
                  ),

                  label: const Text(

                    "إعادة اللعب",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.white,

                    foregroundColor:
                        Colors.blue,

                    elevation: 8,

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 35,

                      vertical: 12,

                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        25,
                      ),

                    ),

                  ),

                ),

                const SizedBox(
                  height: 20,
                ),

              ],

            ),

          ),

        ),

      ),

    );

  }
  @override
  void dispose() {

    audioPlayer.stop();

    audioPlayer.dispose();

    super.dispose();

  }

}
