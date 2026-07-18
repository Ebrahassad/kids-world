import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'games_screen.dart';
import 'progress_manager.dart';


class NumbersScreen extends StatefulWidget {

  const NumbersScreen({super.key});


  @override
  State<NumbersScreen> createState() =>
      _NumbersScreenState();

}



class _NumbersScreenState extends State<NumbersScreen> {


  static const String gameName = "numbers_game";


  final AudioPlayer audioPlayer =
      AudioPlayer();


  final Random random =
      Random();



  int currentQuestion = 0;

  int stars = 0;


  bool loading = true;

  bool answering = false;



  final List<Map<String, dynamic>> questions = [


    {
      "question": "1",
      "answer": "1",
      "options": [
        "1",
        "3",
        "5",
        "8",
      ],
    },


    {
      "question": "2",
      "answer": "2",
      "options": [
        "4",
        "2",
        "6",
        "9",
      ],
    },


    {
      "question": "3",
      "answer": "3",
      "options": [
        "7",
        "1",
        "3",
        "5",
      ],
    },


    {
      "question": "4",
      "answer": "4",
      "options": [
        "4",
        "2",
        "8",
        "6",
      ],
    },


    {
      "question": "5",
      "answer": "5",
      "options": [
        "1",
        "5",
        "3",
        "9",
      ],
    },


    {
      "question": "6",
      "answer": "6",
      "options": [
        "2",
        "8",
        "6",
        "4",
      ],
    },


    {
      "question": "7",
      "answer": "7",
      "options": [
        "7",
        "5",
        "1",
        "3",
      ],
    },


    {
      "question": "8",
      "answer": "8",
      "options": [
        "6",
        "2",
        "8",
        "4",
      ],
    },


    {
      "question": "9",
      "answer": "9",
      "options": [
        "3",
        "7",
        "9",
        "5",
      ],
    },


    {
      "question": "10",
      "answer": "10",
      "options": [
        "8",
        "10",
        "4",
        "2",
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


    questions.shuffle(random);



    for (final item in questions) {


      final List<String> options =
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



    } catch(e) {


      debugPrint(
        "خطأ الصوت: $e",
      );


    }


  }






  Future<void> checkAnswer(String answer) async {


    if(answering) return;



    answering = true;



    final correct =
        questions[currentQuestion]["answer"];



    if(answer == correct) {



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




      if(currentQuestion <
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



        if(!mounted) return;



        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) => WinScreen(

              stars: stars,

              nextGame:
                  const NumbersScreen(),

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


        ),


      );



      answering = false;


    }


  }

  void restartGame() {


    audioPlayer.stop();


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


    if(loading){


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

                  "اختر الرقم الصحيح 🔢",

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


                  width:
                      180,

                  height:
                      180,



                  decoration:
                      BoxDecoration(

                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius.circular(30),


                    boxShadow:
                        const [

                      BoxShadow(

                        color:
                            Colors.black26,

                        blurRadius:
                            8,

                      ),

                    ],

                  ),




                  child:
                      Center(


                    child:
                        Text(


                      data["question"],



                      style:
                          const TextStyle(

                        fontSize:
                            90,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Colors.blue,

                      ),


                    ),


                  ),


                ),



                const SizedBox(
                  height: 25,
                ),
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
                          1.4,


                    ),



                    itemBuilder:
                        (context, index) {



                      final String number =
                          data["options"][index];



                      return InkWell(


                        onTap:
                            answering
                                ? null
                                : () {

                          checkAnswer(number);


                        },



                        borderRadius:
                            BorderRadius.circular(25),




                        child: Container(


                          alignment:
                              Alignment.center,



                          decoration:
                              BoxDecoration(


                            color:
                                Colors.green,


                            borderRadius:
                                BorderRadius.circular(25),



                            boxShadow:
                                const [


                              BoxShadow(

                                color:
                                    Colors.black26,

                                blurRadius:
                                    6,

                                offset:
                                    Offset(0,4),

                              ),


                            ],


                          ),




                          child:
                              Text(


                            number,


                            style:
                                const TextStyle(


                              fontSize:
                                  45,


                              fontWeight:
                                  FontWeight.bold,


                              color:
                                  Colors.white,


                            ),


                          ),


                        ),


                      );


                    },


                  ),


                ),





                ElevatedButton.icon(



                  onPressed:
                      restartGame,



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


                    elevation:
                        6,


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