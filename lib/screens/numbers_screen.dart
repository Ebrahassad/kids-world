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


  static const String gameName =
      "numbers_game";



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
      "question":
          "كم عدد التفاحات؟ 🍎🍎🍎",

      "answer":
          "3",

      "number":
          "🍎 🍎 🍎",

      "options":
          [
            "2",
            "3",
            "5",
            "1",
          ],
    },




    {
      "question":
          "كم عدد النجوم؟ ⭐⭐⭐⭐⭐",

      "answer":
          "5",

      "number":
          "⭐ ⭐ ⭐ ⭐ ⭐",

      "options":
          [
            "4",
            "5",
            "7",
            "2",
          ],
    },





    {
      "question":
          "كم عدد الأسماك؟ 🐟🐟",

      "answer":
          "2",

      "number":
          "🐟 🐟",

      "options":
          [
            "1",
            "2",
            "6",
            "4",
          ],
    },





    {
      "question":
          "كم عدد البالونات؟ 🎈🎈🎈🎈",

      "answer":
          "4",

      "number":
          "🎈 🎈 🎈 🎈",

      "options":
          [
            "3",
            "4",
            "8",
            "6",
          ],
    },





    {
      "question":
          "كم عدد الأقمار؟ 🌙🌙🌙🌙🌙🌙",

      "answer":
          "6",

      "number":
          "🌙 🌙 🌙 🌙 🌙 🌙",

      "options":
          [
            "5",
            "6",
            "9",
            "3",
          ],
    },





    {
      "question":
          "كم عدد الفراشات؟ 🦋🦋🦋🦋🦋🦋🦋",

      "answer":
          "7",

      "number":
          "🦋 🦋 🦋 🦋 🦋 🦋 🦋",

      "options":
          [
            "7",
            "4",
            "10",
            "8",
          ],
    },





    {
      "question":
          "كم عدد الأقلام؟ ✏️✏️✏️✏️✏️✏️✏️✏️",

      "answer":
          "8",

      "number":
          "✏️ ✏️ ✏️ ✏️ ✏️ ✏️ ✏️ ✏️",

      "options":
          [
            "8",
            "6",
            "2",
            "9",
          ],
    },





    {
      "question":
          "كم عدد القلوب؟ ❤️❤️❤️❤️❤️❤️❤️❤️❤️",

      "answer":
          "9",

      "number":
          "❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️",

      "options":
          [
            "9",
            "5",
            "7",
            "10",
          ],
    },





    {
      "question":
          "كم عدد الكرات؟ ⚽⚽⚽⚽⚽⚽⚽⚽⚽⚽",

      "answer":
          "10",

      "number":
          "⚽ ⚽ ⚽ ⚽ ⚽ ⚽ ⚽ ⚽ ⚽ ⚽",

      "options":
          [
            "8",
            "10",
            "4",
            "6",
          ],
    },


  ];



  late List<Map<String,dynamic>> questions;
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


        "number":
            item["number"],


        "options":
            List<String>.from(
              item["options"],
            ),


      };


    }).toList();





    // خلط ترتيب الأسئلة

    questions.shuffle(random);





    // خلط الاختيارات

    for(final item in questions){


      final List<String> options =
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




    if(currentQuestion >= questions.length){

      currentQuestion = 0;

    }





    if(mounted){


      setState((){


        loading = false;


      });


    }


  }







  Future<void> playSound(
      String fileName) async {


    try{


      await audioPlayer.stop();



      await audioPlayer.play(


        AssetSource(

          "sounds/$fileName",

        ),


      );



    }catch(e){


      debugPrint(
        "خطأ الصوت: $e",
      );


    }


  }








  Future<void> checkAnswer(
      String answer) async {



    if(answering) return;



    setState((){


      answering = true;


    });





    final correctAnswer =
        questions[currentQuestion]["answer"];





    if(answer == correctAnswer){



      await playSound(

        "correct.mp3",

      );




      setState((){


        stars++;


      });






      await ProgressManager.saveStars(

        gameName,

        stars,

      );







      if(currentQuestion <
          questions.length - 1){



        setState((){


          currentQuestion++;


          answering = false;



        });






        await ProgressManager.saveProgress(

          gameName,

          currentQuestion,

        );



      }else{



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




    }else{



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



          duration:

              Duration(

                milliseconds: 800,

              ),



        ),



      );





      setState((){


        answering = false;


      });



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

                        horizontal:

                            20,

                        vertical:

                            10,

                      ),





                      decoration:

                          BoxDecoration(



                        color:

                            Colors.white,



                        borderRadius:

                            BorderRadius.circular(

                              20,

                            ),



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

                        horizontal:

                            20,

                        vertical:

                            10,

                      ),




                      decoration:

                          BoxDecoration(



                        color:

                            Colors.white,



                        borderRadius:

                            BorderRadius.circular(

                              20,

                            ),



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



                  "تعلم الأرقام 🔢",



                  style:

                      TextStyle(



                    fontSize:

                        30,



                    fontWeight:

                        FontWeight.bold,



                  ),



                ),








                const SizedBox(

                  height: 15,

                ),







                Text(



                  data["question"],



                  textAlign:

                      TextAlign.center,



                  style:

                      const TextStyle(



                    fontSize:

                        25,



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

                    horizontal:

                        20,

                  ),





                  padding:

                      const EdgeInsets.all(

                        20,

                      ),





                  decoration:

                      BoxDecoration(



                    color:

                        Colors.white,



                    borderRadius:

                        BorderRadius.circular(

                          25,

                        ),



                    boxShadow:

                        const [



                      BoxShadow(



                        color:

                            Colors.black26,



                        blurRadius:

                            8,



                        offset:

                            Offset(

                              0,

                              4,

                            ),



                      ),



                    ],



                  ),








                  child:

                      Center(



                    child:

                        Text(



                      data["number"],



                      textAlign:

                          TextAlign.center,



                      style:

                          const TextStyle(



                        fontSize:

                            45,



                      ),



                    ),



                  ),



                ),







                const SizedBox(

                  height: 20,

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

                        (context,index){



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

                                    Offset(

                                      0,

                                      4,

                                    ),



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