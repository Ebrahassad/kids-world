import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../progress_manager.dart';
import 'win_screen.dart';
import 'games_screen.dart';


class MatchImageScreen extends StatefulWidget {

  const MatchImageScreen({
    super.key,
  });


  @override
  State<MatchImageScreen> createState() =>
      _MatchImageScreenState();

}



class _MatchImageScreenState
    extends State<MatchImageScreen> {


  static const String gameName =
      "match_image";


  final AudioPlayer audioPlayer =
      AudioPlayer();


  final Random random =
      Random();



  int currentQuestion = 0;

  int stars = 0;


  bool loading = true;

  bool answering = false;




  final List<Map<String, dynamic>>
      originalQuestions = [



    {
      "image":
          "assets/images/Puzzle/kids_puzzle.png",

      "answer":
          "assets/images/Puzzle/kids_puzzle.png",

      "options": [

        "assets/images/Puzzle/kids_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

      ],

    },



    {
      "image":
          "assets/images/Puzzle/monkey_puzzle.png",

      "answer":
          "assets/images/Puzzle/monkey_puzzle.png",

      "options": [

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/monkey_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/rabbit_puzzle.png",

      ],

    },



    {
      "image":
          "assets/images/Puzzle/bear_puzzle.png",

      "answer":
          "assets/images/Puzzle/bear_puzzle.png",

      "options": [

        "assets/images/Puzzle/lion_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/dinosaur_puzzle.png",

      ],

    },



    {
      "image":
          "assets/images/Puzzle/fish_puzzle.png",

      "answer":
          "assets/images/Puzzle/fish_puzzle.png",

      "options": [

        "assets/images/Puzzle/butterfly_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/dog_puzzle.png",

      ],

    },
    {
      "image":
          "assets/images/Puzzle/dinosaur_puzzle.png",

      "answer":
          "assets/images/Puzzle/dinosaur_puzzle.png",

      "options": [

        "assets/images/Puzzle/rabbit_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

        "assets/images/Puzzle/dinosaur_puzzle.png",

        "assets/images/Puzzle/monkey_puzzle.png",

      ],

    },


    {
      "image":
          "assets/images/Puzzle/butterfly_puzzle.png",

      "answer":
          "assets/images/Puzzle/butterfly_puzzle.png",

      "options": [

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/butterfly_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/kids_puzzle.png",

      ],

    },


    {
      "image":
          "assets/images/Puzzle/dog_puzzle.png",

      "answer":
          "assets/images/Puzzle/dog_puzzle.png",

      "options": [

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

      ],

    },


    {
      "image":
          "assets/images/Puzzle/cat_puzzle.png",

      "answer":
          "assets/images/Puzzle/cat_puzzle.png",

      "options": [

        "assets/images/Puzzle/rabbit_puzzle.png",

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/cat_puzzle.png",

        "assets/images/Puzzle/monkey_puzzle.png",

      ],

    },


    {
      "image":
          "assets/images/Puzzle/rabbit_puzzle.png",

      "answer":
          "assets/images/Puzzle/rabbit_puzzle.png",

      "options": [

        "assets/images/Puzzle/fish_puzzle.png",

        "assets/images/Puzzle/rabbit_puzzle.png",

        "assets/images/Puzzle/dinosaur_puzzle.png",

        "assets/images/Puzzle/butterfly_puzzle.png",

      ],

    },


    {
      "image":
          "assets/images/Puzzle/lion_puzzle.png",

      "answer":
          "assets/images/Puzzle/lion_puzzle.png",

      "options": [

        "assets/images/Puzzle/bear_puzzle.png",

        "assets/images/Puzzle/dog_puzzle.png",

        "assets/images/Puzzle/lion_puzzle.png",

        "assets/images/Puzzle/kids_puzzle.png",

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

    questions =
        originalQuestions.map((item) {

      return {

        "image": item["image"],

        "answer": item["answer"],

        "options":
            List<String>.from(
              item["options"],
            ),

      };

    }).toList();



    questions.shuffle(random);



    for (final item in questions) {

      List<String> options =
          List<String>.from(
            item["options"],
          );


      options.shuffle(random);


      item["options"] =
          options;

    }

  }




  Future<void> loadProgress() async {


    currentQuestion =
        await ProgressManager.getProgress(
          gameName,
        );


    stars =
        await ProgressManager.getStars(
          gameName,
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


    answering = true;



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

        gameName,

        stars,

      );



      await Future.delayed(

        const Duration(
          milliseconds: 700,
        ),

      );




      if (!mounted) return;




      if (currentQuestion <
          questions.length - 1) {



        setState(() {

          currentQuestion++;

          answering = false;

        });



        await ProgressManager.saveProgress(

          gameName,

          currentQuestion,

        );



      } else {



        await ProgressManager.saveCompletedGame(

          gameName,

        );



        await ProgressManager.saveProgress(

          gameName,

          0,

        );



        if (!mounted) return;



        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) => WinScreen(

              stars: stars,


              nextGame:

                  const MatchImageScreen(),



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

          duration:

              Duration(
                milliseconds: 800,
              ),

        ),

      );



      await Future.delayed(

        const Duration(
          milliseconds: 800,
        ),

      );



      if (mounted) {

        setState(() {

          answering = false;

        });

      }



    }


  }
  void restartGame() {

  prepareGame();

  setState(() {

    currentQuestion = 0;

    answering = false;

  });


  ProgressManager.resetGameRound(
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



    final data =
        questions[currentQuestion];



    return Scaffold(


      body: Container(


        width:
            double.infinity,


        height:
            double.infinity,



        decoration:
            const BoxDecoration(


          image:
              DecorationImage(


            image:
                AssetImage(
              "assets/images/background.png",
            ),


            fit:
                BoxFit.cover,


          ),


        ),



        child: Container(


          color:
              Colors.white.withOpacity(0.25),



          child: SafeArea(


            child: Column(


              children: [



                const SizedBox(
                  height: 15,
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


                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                      ),


                      child:
                          Text(

                        "⭐ $stars",


                        style:
                            const TextStyle(

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
                        horizontal: 15,
                        vertical: 10,
                      ),


                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                      ),


                      child:
                          Text(

                        "${currentQuestion + 1}/${questions.length}",


                        style:
                            const TextStyle(

                          fontSize:
                              22,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ),


                  ],

                ),



                const SizedBox(
                  height: 25,
                ),




                const Text(

                  "اختر الصورة المطابقة 🎯",

                  style:
                      TextStyle(

                    fontSize:
                        28,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),




                const SizedBox(
                  height: 20,
                ),




                Container(

                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),


                  padding:
                      const EdgeInsets.all(15),


                  decoration:
                      BoxDecoration(

                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius.circular(25),

                  ),



                  child:
                      Image.asset(

                    data["image"],


                    height:
                        MediaQuery.of(context)
                            .size
                            .height *
                            0.25,


                    fit:
                        BoxFit.contain,


                  ),


                ),




                const SizedBox(
                  height: 20,
                ),




                Expanded(


                  child:
                      GridView.builder(


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


                    ),



                    itemBuilder:
                        (context,index) {


                      final image =
                          data["options"][index];



                      return GestureDetector(


                        onTap:
                            answering
                                ? null
                                : () async {

                          await checkAnswer(
                            image,
                          );

                        },



                        child:
                            Card(


                          elevation:
                              6,


                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(20),

                          ),



                          child:
                              Padding(

                            padding:
                                const EdgeInsets.all(10),


                            child:
                                Image.asset(

                              image,

                              fit:
                                  BoxFit.contain,

                            ),

                          ),



                        ),



                      );


                    },


                  ),

                ),




                ElevatedButton.icon(


                  onPressed:
                      answering
                          ? null
                          : restartGame,



                  icon:
                      const Icon(
                    Icons.refresh,
                  ),



                  label:
                      const Text(

                    "إعادة اللعب",

                    style:
                        TextStyle(

                      fontSize:
                          20,

                      fontWeight:
                          FontWeight.bold,

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