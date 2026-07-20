import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import '../progress_manager.dart';

class WinScreen extends StatefulWidget {

  final int stars;

final int gameId;

  final Widget nextGame;

  final Widget gamesPage;

  // هل اللعبة تحتوي على مستويات؟
  final bool hasLevels;

  // المستوى الحالي
  final int currentLevel;

  // عدد المستويات
  final int maxLevels;

  // صفحة المستوى التالي
  final Widget? nextLevelPage;

  const WinScreen({

    super.key,

    required this.stars,
required this.gameId,

    required this.nextGame,

    required this.gamesPage,

    this.hasLevels = false,

    this.currentLevel = 1,

    this.maxLevels = 1,

    this.nextLevelPage,

  });

  @override
  State<WinScreen> createState() =>
      _WinScreenState();
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

    playWinSound();

    confettiController.play();

Future.microtask(() {
  unlockGame();
});

    

  }

  
Future<int> getTotalStars() {
  return ProgressManager.getTotalStars();
}

Future<void> unlockGame() async {

  await ProgressManager.unlockNextGame(
    widget.gameId,
  );

}

  Future<void> playWinSound() async {

    try {

      await audioPlayer.play(
        AssetSource(
          "sounds/win.mp3",
        ),
      );

    } catch (e) {

      debugPrint(
        "خطأ الصوت: $e",
      );

    }

  }

  @override
  void dispose() {

    audioPlayer.dispose();

    confettiController.dispose();

    super.dispose();

  }

  Widget actionButton({

    required String text,

    required IconData icon,

    required Color color,

    required VoidCallback onPressed,

  }) {

    return SizedBox(

      width: 270,

      height: 60,

      child: ElevatedButton.icon(

        onPressed: onPressed,

        icon: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),

        label: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        style: ElevatedButton.styleFrom(

          backgroundColor: color,

          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(25),

          ),

        ),

      ),

    );

  }
  @override
  Widget build(BuildContext context) {

    final bool isLastLevel =
        widget.currentLevel >= widget.maxLevels;

    return Scaffold(

      backgroundColor:
          const Color(0xffB3E5FC),

      body: Stack(

        alignment: Alignment.center,

        children: [

          Align(

            alignment: Alignment.topCenter,

            child: ConfettiWidget(

              confettiController:
                  confettiController,

              blastDirectionality:
                  BlastDirectionality.explosive,

              shouldLoop: false,

              numberOfParticles: 50,

            ),

          ),

          Center(

            child: SingleChildScrollView(

              child: Padding(

                padding:
                    const EdgeInsets.all(25),

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    const Text(

                      "🎉🏆⭐",

                      style: TextStyle(
                        fontSize: 80,
                      ),

                    ),

                    const SizedBox(height: 20),

                    const Text(

                      "مبروك! 🎊",

                      style: TextStyle(

                        fontSize: 42,

                        fontWeight:
                            FontWeight.bold,

                        color: Colors.green,

                      ),

                    ),

                    const SizedBox(height: 20),

                    const Text(

                      "أكملت اللعبة بنجاح 👏",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        fontSize: 23,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),

                    const SizedBox(height: 25),

                    FutureBuilder<int>(
  future: getTotalStars(),
  builder: (context, snapshot) {
    final totalStars = snapshot.data ?? widget.stars;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "إجمالي النجوم ⭐ $totalStars",
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
    );
  },
),
                   const SizedBox(height: 40),
                    // زر المستوى التالي (يظهر فقط في الألعاب ذات المستويات)
                    if (widget.hasLevels)

                      actionButton(

                        text: isLastLevel
                            ? "العودة إلى المراحل 📋"
                            : "المستوى التالي ➡",

                        icon: isLastLevel
                            ? Icons.list
                            : Icons.arrow_forward,

                        color: Colors.orange,

                        onPressed: () {

                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(

                              builder: (_) {

  if (isLastLevel || widget.nextLevelPage == null) {
    return widget.gamesPage;
  }

  return widget.nextLevelPage!;

},

                            ),

                          );

                        },

                      ),

                    if (widget.hasLevels)
                      const SizedBox(height: 15),

                    // إعادة اللعب
                    actionButton(

                      text: "إعادة اللعب 🔄",

                      icon: Icons.refresh,

                      color: Colors.green,

                      onPressed: () {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                widget.nextGame,

                          ),

                        );

                      },

                    ),

                    const SizedBox(height: 15),

                    // إذا كانت اللعبة بدون مستويات يظهر زر الألعاب
                    // وإذا كانت بمستويات يظهر زر المراحل
                    actionButton(

                      text: widget.hasLevels
                          ? "المراحل 📋"
                          : "صفحة الألعاب 🎮",

                      icon: widget.hasLevels
                          ? Icons.list
                          : Icons.games,

                      color: Colors.blue,

                      onPressed: () {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                widget.gamesPage,

                          ),

                        );

                      },

                    ),

                    const SizedBox(height: 15),

                    actionButton(

                      text: "إغلاق التطبيق 🚪",

                      icon: Icons.exit_to_app,

                      color: Colors.red,

                      onPressed: () {

                        SystemNavigator.pop();

                      },

                    ),

                  ],

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }

}