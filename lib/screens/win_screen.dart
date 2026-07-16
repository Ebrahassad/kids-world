import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';

import 'game_screen.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({super.key});

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();

    confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );

    audioPlayer.play(
      AssetSource('sounds/win.mp3'),
    );

    confettiController.play();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,

      body: Stack(
        alignment: Alignment.center,

        children: [

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality:
                  BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 40,
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Text(
                    "🎉🏆🎉",
                    style: TextStyle(
                      fontSize: 80,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "مبروك!",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "لقد أكملت جميع المراحل بنجاح ⭐",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: 240,
                    height: 60,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                      ),

                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const GameScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        "إعادة اللعب 🔄",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },

                    child: const Text(
                      "العودة للرئيسية 🏠",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}