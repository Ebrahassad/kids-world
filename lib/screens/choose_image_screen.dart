import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'games_screen.dart';
import '../progress_manager.dart';


class ChooseImageScreen extends StatefulWidget {

  const ChooseImageScreen({
    super.key,
  });

  @override
  State<ChooseImageScreen> createState() =>
      _ChooseImageScreenState();

}


class _ChooseImageScreenState
    extends State<ChooseImageScreen> {


  final AudioPlayer audioPlayer = AudioPlayer();

  final Random random = Random();



  int currentQuestion = 0;

  int stars = 0;

  bool loading = true;

  bool answering = false;



  final List<Map<String, dynamic>> originalQuestions = [


    {
      "question": "أين الأطفال؟ 🧒",

      "answer":
          "assets/images/Puzzle/kids_puzzle.png",

      "options": [

        "assets/images/Puzzle/kids_puzzle.png",

        "assets/images/Puzzle/monkey_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

      ],

    },


    {
      "question": "أين القرد؟ 🐒",

      "answer":
          "assets/images/Puzzle/monkey_puzzle.png",

      "options": [

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/monkey_puzzle.png",

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

      ],

    },


    {
      "question": "أين الدب؟ 🐻",

      "answer":
          "assets/images/Puzzle/bear_puzzle.png",

      "options": [

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/rabbit_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/butterfly_puzzle.png",

      ],

    },


    {
      "question": "أين السمكة؟ 🐟",

      "answer":
          "assets/images/Puzzle/fish_puzzle.png",

      "options": [

        "assets/images/Puzzle/lion_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/dinosaur_puzzle.png",

        "assets/images/Puzzle/cat_puzzle.png",

      ],

    },


    {
      "question": "أين الديناصور؟ 🦖",

      "answer":
          "assets/images/Puzzle/dinosaur_puzzle.png",

      "options": [

        "assets/images/Puzzle/dinosaur_puzzle.png",

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/monkey_puzzle.png",

      ],

    },



    {
      "question": "أين الفراشة؟ 🦋",

      "answer":
          "assets/images/Puzzle/butterfly_puzzle.png",

      "options": [

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/butterfly_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/rabbit_puzzle.png",

      ],

    },


    {
      "question": "أين الكلب؟ 🐶",

      "answer":
          "assets/images/Puzzle/dog_puzzle.png",

      "options": [

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

        "assets/images/Puzzle/butterfly_puzzle.png",

        "assets/images/Puzzle/kids_puzzle.png",

      ],

    },


    {
      "question": "أين القطة؟ 🐱",

      "answer":
          "assets/images/Puzzle/cat_puzzle.png",

      "options": [

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/dinosaur_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

      ],

    },


    {
      "question": "أين الأرنب؟ 🐰",

      "answer":
          "assets/images/Puzzle/rabbit_puzzle.png",

      "options": [

        "assets/images/Puzzle/rabbit_puzzle.png",

        "assets/images/Puzzle/monkey_puzzle.png",

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

      ],

    },


    {
      "question": "أين الأسد؟ 🦁",

      "answer":
          "assets/images/Puzzle/lion_puzzle.png",

      "options": [

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

      ],

    },


  ];



  late List<Map<String, dynamic>> questions;
  @override
  void initState() {

    super.initState();

    prepareGame();

    loadProgress();

  }



  void prepareGame() {

    questions = originalQuestions.map((item) {

      return {

        "question": item["question"],

        "answer": item["answer"],

        "options":
            List<String>.from(
              item["options"],
            ),

      };

    }).toList();



    // خلط ترتيب الأسئلة

    questions.shuffle(random);



    // خلط الخيارات داخل كل سؤال

    for (final item in questions) {

      final options =
          List<String>.from(
            item["options"],
          );


      options.shuffle(random);


      item["options"] = options;

    }

  }




  Future<void> loadProgress() async {

    currentQuestion =
        await ProgressManager.getProgress(
      "choose_image",
    );


    stars =
        await ProgressManager.getStars(
      "choose_image",
    );



    if (currentQuestion >= questions.length) {

      currentQuestion = 0;

    }



    if (mounted) {

      setState(() {

        loading = false;

      });

    }

  }




  Future<void> playSound(String fileName) async {

    try {

      await audioPlayer.stop();


      await audioPlayer.play(

        AssetSource(
          "sounds/$fileName",
        ),

      );


    } catch (e) {

      debugPrint(
        "خطأ الصوت: $e",
      );

    }

  }





  Future<void> checkAnswer(String image) async {


    if (answering) return;


    setState(() {

      answering = true;

    });



    final correct =
        questions[currentQuestion]["answer"];



    if (image == correct) {


      await playSound(
        "correct.mp3",
      );


      setState(() {

        stars++;

      });



      await ProgressManager.saveStars(

        "choose_image",

        stars,

      );



      await Future.delayed(

        const Duration(
          milliseconds: 700,
        ),

      );



      if (currentQuestion <
          questions.length - 1) {


        setState(() {

          currentQuestion++;

          answering = false;

        });



        await ProgressManager.saveProgress(

          "choose_image",

          currentQuestion,

        );



      } else {


        await ProgressManager.saveCompletedGame(

          "choose_image",

        );


        await ProgressManager.saveProgress(

          "choose_image",

          0,

        );



        if (!mounted) return;



        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) => WinScreen(

              stars: stars,
gameId: 2,
              nextGame:
                  const ChooseImageScreen(),

              gamesPage:
                  const GamesScreen(),

            ),

          ),

        );


      }



    } else {


      await playSound(

        "wrong.mp3",

      );



      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
                "❌ حاول مرة أخرى",
              ),

          backgroundColor:
              Colors.red,

        ),

      );



      await Future.delayed(

        const Duration(
          milliseconds: 700,
        ),

      );



      if (mounted) {

        setState(() {

          answering = false;

        });

      }

    }

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



    final data =
        questions[currentQuestion];



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

          color:
              Colors.white.withOpacity(0.25),



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

                        horizontal: 20,

                        vertical: 10,

                      ),


                      decoration: BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                        boxShadow: const [

                          BoxShadow(

                            color:
                                Colors.black12,

                            blurRadius:
                                5,

                          ),

                        ],

                      ),



                      child: Text(

                        "⭐ $stars",


                        style: const TextStyle(

                          fontSize:
                              24,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              Colors.orange,

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

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                      ),



                      child: Text(

                        "${currentQuestion + 1}/${questions.length}",


                        style: const TextStyle(

                          fontSize:
                              22,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ),



                  ],

                ),




                const SizedBox(height: 25),




                Text(

                  data["question"],


                  textAlign:
                      TextAlign.center,


                  style: const TextStyle(

                    fontSize:
                        30,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),




                const SizedBox(height: 20),





                Expanded(


                  child: GridView.builder(


                    padding:
                        const EdgeInsets.all(20),



                    itemCount:
                        data["options"].length,



                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(


                      crossAxisCount:
                          2,


                      crossAxisSpacing:
                          15,


                      mainAxisSpacing:
                          15,


                      childAspectRatio:
                          0.9,


                    ),



                    itemBuilder:
                        (context,index) {



                      final image =
                          data["options"][index];



                      return GestureDetector(


                        onTap:

                            answering

                                ? null

                                : () {

                                  checkAnswer(
                                    image,
                                  );

                                },



                        child: AnimatedContainer(


                          duration:
                              const Duration(
                                milliseconds:300,
                              ),



                          padding:
                              const EdgeInsets.all(10),



                          decoration:
                              BoxDecoration(


                            color:
                                Colors.white,


                            borderRadius:
                                BorderRadius.circular(25),


                            boxShadow:
                                const [

                              BoxShadow(

                                color:
                                    Colors.black26,

                                blurRadius:
                                    8,

                                offset:
                                    Offset(0,4),

                              ),

                            ],


                          ),




                          child: Image.asset(


                            image,


                            fit:
                                BoxFit.contain,


                          ),



                        ),


                      );


                    },


                  ),


                ),





                const SizedBox(height:15),




                ElevatedButton.icon(


                  onPressed: () {


                    prepareGame();


                    setState(() {


                      currentQuestion = 0;

                      

                      answering = false;


                    });


                    ProgressManager.resetProgress(

                      "choose_image",

                    );


                  },



                  icon:
                      const Icon(
                        Icons.refresh,
                      ),



                  label:
                      const Text(

                        "إعادة اللعب",

                        style: TextStyle(

                          fontSize:
                              20,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),



                  style:
                      ElevatedButton.styleFrom(


                    padding:
                        const EdgeInsets.symmetric(

                      horizontal:
                          35,

                      vertical:
                          12,

                    ),


                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(25),

                    ),

                  ),


                ),




                const SizedBox(height:20),



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
