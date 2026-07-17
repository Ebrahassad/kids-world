import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'win_screen.dart';
import 'levels_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final Random random = Random();

  final List<Map<String, dynamic>> originalQuestions = [
    {
      "image": "assets/images/Puzzle/kids_puzzle.png",
      "answer": "أطفال",
      "options": ["أطفال", "قرد", "أسد", "سمكة"],
    },
    {
      "image": "assets/images/Puzzle/monkey_puzzle.png",
      "answer": "قرد",
      "options": ["دب", "قرد", "قطة", "كلب"],
    },
    {
      "image": "assets/images/Puzzle/bear_puzzle.png",
      "answer": "دب",
      "options": ["سمكة", "دب", "أرنب", "أسد"],
    },
    {
      "image": "assets/images/Puzzle/fish_puzzle.png",
      "answer": "سمكة",
      "options": ["فراشة", "سمكة", "كلب", "ديناصور"],
    },
    {
      "image": "assets/images/Puzzle/dinosaur_puzzle.png",
      "answer": "ديناصور",
      "options": ["قرد", "ديناصور", "أسد", "دب"],
    },
    {
      "image": "assets/images/Puzzle/butterfly_puzzle.png",
      "answer": "فراشة",
      "options": ["قطة", "كلب", "فراشة", "سمكة"],
    },
    {
      "image": "assets/images/Puzzle/dog_puzzle.png",
      "answer": "كلب",
      "options": ["كلب", "أرنب", "دب", "أسد"],
    },
    {
      "image": "assets/images/Puzzle/cat_puzzle.png",
      "answer": "قطة",
      "options": ["قطة", "سمكة", "قرد", "ديناصور"],
    },
    {
      "image": "assets/images/Puzzle/rabbit_puzzle.png",
      "answer": "أرنب",
      "options": ["فراشة", "كلب", "أرنب", "أسد"],
    },
    {
      "image": "assets/images/Puzzle/lion_puzzle.png",
      "answer": "أسد",
      "options": ["دب", "أسد", "قطة", "سمكة"],
    },
  ];

  late List<Map<String, dynamic>> questions;

  int currentQuestion = 0;
  int stars = 0;

  bool answered = false;
  bool loadingNextQuestion = false;

  @override
  void initState() {
    super.initState();
    prepareGame();
  }

  void prepareGame() {
    questions = originalQuestions.map((item) {
      return {
        "image": item["image"],
        "answer": item["answer"],
        "options": List<String>.from(item["options"]),
      };
    }).toList();

    questions.shuffle(random);

    for (final item in questions) {
      final options = List<String>.from(item["options"]);
      options.shuffle(random);
      item["options"] = options;
    }
  }

  Future<void> playSound(String fileName) async {
    try {
      await audioPlayer.stop();

      await audioPlayer.play(
        AssetSource("sounds/$fileName"),
      );
    } catch (e) {
      debugPrint("خطأ في تشغيل الصوت: $e");
    }
  }

  Future<void> checkAnswer(String answer) async {
    if (answered || loadingNextQuestion) return;

    setState(() {
      answered = true;
    });

    final correctAnswer =
        questions[currentQuestion]["answer"];

    if (answer == correctAnswer) {
      await playSound("correct.mp3");

      setState(() {
        stars++;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🎉 إجابة صحيحة"),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 700),
        ),
      );

      goNextQuestion();
    } else {
      await playSound("wrong.mp3");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ حاول مرة أخرى"),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 800),
        ),
      );

      Future.delayed(
        const Duration(milliseconds: 800),
        () {
          if (!mounted) return;

          setState(() {
            answered = false;
          });
        },
      );
    }
  }
  Future<void> goNextQuestion() async {
    setState(() {
      loadingNextQuestion = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
        loadingNextQuestion = false;
      });
    } else {
      setState(() {
        loadingNextQuestion = false;
      });

      await playSound("win.mp3");

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => WinScreen(
      stars: stars,
      nextGame: const GameScreen(),
      gamesPage: const LevelsScreen(),
    ),
  ),
);
    }
  }


  void restartGame() {
    audioPlayer.stop();

    prepareGame();

    setState(() {
      currentQuestion = 0;
      stars = 0;
      answered = false;
      loadingNextQuestion = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final data = questions[currentQuestion];

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
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,

                  children: [

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                          ),
                        ],
                      ),

                      child: Text(
                        "⭐ $stars",

                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),


                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                          ),
                        ],
                      ),

                      child: Text(
                        "السؤال ${currentQuestion + 1}/${questions.length}",

                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 20),


                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),

                  child: LinearProgressIndicator(
                    value:
                        (currentQuestion + 1) /
                        questions.length,

                    minHeight: 8,

                    borderRadius:
                        BorderRadius.circular(20),

                    backgroundColor:
                        Colors.white,

                    valueColor:
                        const AlwaysStoppedAnimation(
                      Colors.lightGreen,
                    ),
                  ),
                ),


                const SizedBox(height: 20),
                Container(
                  margin:
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),

                  padding:
                      const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(25),

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: AnimatedSwitcher(
                    duration:
                        const Duration(
                          milliseconds: 400,
                        ),

                    transitionBuilder:
                        (child, animation) {

                      return ScaleTransition(
                        scale: animation,

                        child: FadeTransition(
                          opacity: animation,

                          child: child,
                        ),
                      );
                    },

                    child: Image.asset(
                      data["image"],

                      key:
                          ValueKey(
                            data["image"],
                          ),

                      height:
                          MediaQuery.of(context)
                              .size
                              .height *
                          0.32,

                      fit:
                          BoxFit.contain,

                      errorBuilder:
                          (context, error, stackTrace) {

                        return const Icon(
                          Icons.image_not_supported,

                          size: 120,

                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),


                const SizedBox(height: 20),


                const Text(
                  "اختر الإجابة الصحيحة 🎯",

                  style: TextStyle(
                    fontSize: 24,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 15),


                Expanded(
                  child: GridView.builder(

                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),

                    itemCount:
                        data["options"].length,


                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,

                      crossAxisSpacing: 15,

                      mainAxisSpacing: 15,

                      childAspectRatio: 2,

                    ),


                    itemBuilder:
                        (context, index) {


                      final String option =
                          data["options"][index];


                      return AnimatedScale(

                        duration:
                            const Duration(
                              milliseconds: 180,
                            ),

                        curve:
                            Curves.easeInOut,


                        scale:
                            answered ? 0.95 : 1,


                        child: InkWell(

                          borderRadius:
                              BorderRadius.circular(20),


                          splashColor:
                              Colors.blue.shade100,


                          onTap:
                              (loadingNextQuestion ||
                                      answered)

                                  ? null

                                  : () async =>
                                      await checkAnswer(
                                        option,
                                      ),


                          child: AnimatedContainer(

                            duration:
                                const Duration(
                                  milliseconds: 200,
                                ),


                            alignment:
                                Alignment.center,


                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white,


                              borderRadius:
                                  BorderRadius.circular(
                                    20,
                                  ),


                              boxShadow:
                                  const [

                                BoxShadow(

                                  color:
                                      Colors.black26,


                                  blurRadius:
                                      5,


                                  offset:
                                      Offset(
                                        0,
                                        3,
                                      ),

                                ),

                              ],

                            ),


                            child: Padding(

                              padding:
                                  const EdgeInsets.all(
                                    8,
                                  ),


                              child: Text(

                                option,


                                textAlign:
                                    TextAlign.center,


                                maxLines:
                                    2,


                                overflow:
                                    TextOverflow.ellipsis,


                                style:
                                    const TextStyle(

                                  fontSize: 22,


                                  fontWeight:
                                      FontWeight.bold,

                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),


                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed:
                      loadingNextQuestion
                          ? null
                          : restartGame,

                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 28,
                  ),

                  label: const Text(
                    "إعادة اللعب",

                    style: TextStyle(
                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.white,

                    foregroundColor:
                        Colors.blue,

                    elevation:
                        8,

                    shadowColor:
                        Colors.black45,

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


                const SizedBox(height: 20),
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