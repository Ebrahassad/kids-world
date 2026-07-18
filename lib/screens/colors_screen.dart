import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'games_screen.dart';
import 'progress_manager.dart';



class ColorsScreen extends StatefulWidget {

  const ColorsScreen({
    super.key,
  });


  @override
  State<ColorsScreen> createState() =>
      _ColorsScreenState();

}




class _ColorsScreenState
    extends State<ColorsScreen> {


  static const String gameName =
      "colors_game";



  final AudioPlayer audioPlayer =
      AudioPlayer();



  final Random random =
      Random();



  int currentQuestion = 0;


  int stars = 0;



  bool loading = true;


  bool answering = false;




  late List<Map<String, dynamic>> questions;





  final List<Map<String, dynamic>>
      originalQuestions = [



    {
      "question":
          "اختر اللون الأحمر 🔴",

      "answer":
          Colors.red,

      "options": [

        Colors.red,

        Colors.blue,

        Colors.green,

        Colors.yellow,

      ],

    },



    {
      "question":
          "اختر اللون الأزرق 🔵",

      "answer":
          Colors.blue,

      "options": [

        Colors.red,

        Colors.orange,

        Colors.blue,

        Colors.green,

      ],

    },



    {
      "question":
          "اختر اللون الأخضر 🟢",

      "answer":
          Colors.green,

      "options": [

        Colors.purple,

        Colors.green,

        Colors.red,

        Colors.yellow,

      ],

    },



    {
      "question":
          "اختر اللون الأصفر 🟡",

      "answer":
          Colors.yellow,

      "options": [

        Colors.blue,

        Colors.yellow,

        Colors.black,

        Colors.red,

      ],

    },



    {
      "question":
          "اختر اللون البرتقالي 🟠",

      "answer":
          Colors.orange,

      "options": [

        Colors.orange,

        Colors.green,

        Colors.purple,

        Colors.blue,

      ],

    },

    {
      "question":
          "اختر اللون البنفسجي 🟣",

      "answer":
          Colors.purple,

      "options": [

        Colors.yellow,

        Colors.red,

        Colors.purple,

        Colors.green,

      ],

    },


    {
      "question":
          "اختر اللون الأسود ⚫",

      "answer":
          Colors.black,

      "options": [

        Colors.black,

        Colors.white,

        Colors.red,

        Colors.blue,

      ],

    },


    {
      "question":
          "اختر اللون الأبيض ⚪",

      "answer":
          Colors.white,

      "options": [

        Colors.green,

        Colors.orange,

        Colors.white,

        Colors.purple,

      ],

    },


    {
      "question":
          "اختر اللون البني 🟤",

      "answer":
          Colors.brown,

      "options": [

        Colors.blue,

        Colors.brown,

        Colors.yellow,

        Colors.red,

      ],

    },


    {
      "question":
          "اختر اللون الوردي 🩷",

      "answer":
          Colors.pink,

      "options": [

        Colors.green,

        Colors.pink,

        Colors.orange,

        Colors.black,

      ],

    },


  ];





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

        "question":
            item["question"],


        "answer":
            item["answer"],


        "options":
            List<Color>.from(
              item["options"],
            ),


      };


    }).toList();



    questions.shuffle(
      random,
    );



    for (var item in questions) {


      final options =
          List<Color>.from(
            item["options"],
          );


      options.shuffle(
        random,
      );


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



    if (currentQuestion >=
        questions.length) {

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





  Future<void> checkAnswer(Color color) async {


    if (answering) return;


    setState(() {

      answering = true;

    });




    final correctColor =
        questions[currentQuestion]["answer"];




    if (color == correctColor) {



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




        await playSound(

          "win.mp3",

        );




        if (!mounted) return;




        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) => WinScreen(

              stars: stars,


              nextGame:
                  const ColorsScreen(),



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
                "حاول مرة أخرى ⭐",
              ),


          backgroundColor:

              Colors.red,


        ),


      );




      setState(() {


        answering = false;


      });



    }


  }






  void restartGame() {


    prepareGame();



    setState(() {


      currentQuestion = 0;


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


                    Text(

                      "⭐ $stars",

                      style:
                          const TextStyle(

                        fontSize:
                            25,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Colors.orange,

                      ),

                    ),



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


                  ],

                ),




                const SizedBox(
                  height: 25,
                ),





                Text(

                  data["question"],


                  textAlign:
                      TextAlign.center,


                  style:
                      const TextStyle(

                    fontSize:
                        30,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),





                const SizedBox(
                  height: 30,
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
                          20,


                      mainAxisSpacing:
                          20,


                    ),



                    itemBuilder:
                        (context,index) {


                      final Color color =
                          data["options"][index];



                      return GestureDetector(


                        onTap:
                            answering
                                ? null
                                : () {

                          checkAnswer(
                            color,
                          );

                        },



                        child:
                            AnimatedContainer(


                          duration:
                              const Duration(
                            milliseconds: 300,
                          ),



                          decoration:
                              BoxDecoration(


                            color:
                                color,



                            borderRadius:
                                BorderRadius.circular(25),



                            border:
                                Border.all(

                              color:
                                  Colors.black,

                              width:
                                  3,

                            ),



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



                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.white,


                    foregroundColor:
                        Colors.blue,



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