import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'games_screen.dart';

import '../progress_manager.dart';

class LettersScreen extends StatefulWidget {

  const LettersScreen({super.key});


  @override
  State<LettersScreen> createState() =>
      _LettersScreenState();

}



class _LettersScreenState extends State<LettersScreen> {


  static const String gameName =
      "letters_game";


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
          "اختر الحرف الذي يبدأ به اسم: أسد 🦁",
      "answer":
          "أ",
      "options":
          ["أ","ب","ت","ج"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: بطة 🦆",
      "answer":
          "ب",
      "options":
          ["د","ب","ر","س"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: تفاحة 🍎",
      "answer":
          "ت",
      "options":
          ["ت","ث","ج","ك"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: ثعلب 🦊",
      "answer":
          "ث",
      "options":
          ["ث","ت","ذ","ف"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: جمل 🐪",
      "answer":
          "ج",
      "options":
          ["ج","ح","د","ر"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: حصان 🐴",
      "answer":
          "ح",
      "options":
          ["ح","خ","ج","م"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: خروف 🐑",
      "answer":
          "خ",
      "options":
          ["خ","ح","د","س"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: دب 🐻",
      "answer":
          "د",
      "options":
          ["د","ذ","ر","ز"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: ذرة 🌽",
      "answer":
          "ذ",
      "options":
          ["ذ","د","ز","ر"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: رمان 🍎",
      "answer":
          "ر",
      "options":
          ["ر","ز","س","ش"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: زهرة 🌸",
      "answer":
          "ز",
      "options":
          ["ز","ر","س","ص"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: سمكة 🐟",
      "answer":
          "س",
      "options":
          ["س","ش","ص","ط"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: شمس ☀️",
      "answer":
          "ش",
      "options":
          ["ش","س","ض","ع"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: صقر 🦅",
      "answer":
          "ص",
      "options":
          ["ص","ض","ط","ظ"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: ضفدع 🐸",
      "answer":
          "ض",
      "options":
          ["ض","ص","ط","ع"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: طائرة ✈️",
      "answer":
          "ط",
      "options":
          ["ط","ظ","ض","ف"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: ظرف ✉️",
      "answer":
          "ظ",
      "options":
          ["ظ","ط","ض","ع"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: عصفور 🐦",
      "answer":
          "ع",
      "options":
          ["ع","غ","ف","ق"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: غزال 🦌",
      "answer":
          "غ",
      "options":
          ["غ","ع","ف","ك"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: فراشة 🦋",
      "answer":
          "ف",
      "options":
          ["ف","ق","ك","ل"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: قطة 🐱",
      "answer":
          "ق",
      "options":
          ["ق","ك","ل","م"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: كلب 🐶",
      "answer":
          "ك",
      "options":
          ["ك","ق","ل","ن"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: ليمون 🍋",
      "answer":
          "ل",
      "options":
          ["ل","م","ن","هـ"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: موز 🍌",
      "answer":
          "م",
      "options":
          ["م","ن","و","ي"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: نحلة 🐝",
      "answer":
          "ن",
      "options":
          ["ن","م","هـ","و"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: هلال 🌙",
      "answer":
          "هـ",
      "options":
          ["هـ","و","ي","ن"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: وردة 🌹",
      "answer":
          "و",
      "options":
          ["و","هـ","ي","م"],
    },


    {
      "question":
          "اختر الحرف الذي يبدأ به اسم: يد ✋",
      "answer":
          "ي",
      "options":
          ["ي","و","هـ","ك"],
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


        "question":
            item["question"],


        "answer":
            item["answer"],


        "options":
            List<String>.from(
              item["options"],
            ),


      };


    }).toList();



    // خلط ترتيب الأسئلة

    questions.shuffle(random);



    // خلط أماكن الحروف

    for (var item in questions) {


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
        "خطأ تشغيل الصوت: $e",
      );


    }


  }







  Future<void> checkAnswer(
      String answer) async {



    if(answering) return;



    answering = true;




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

gameId:
6,
              nextGame:
                  const LettersScreen(),


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





    if(questions.isEmpty){


      return const Scaffold(

        body: Center(

          child:

              Text(

                "لا توجد أسئلة",

                style:

                    TextStyle(

                  fontSize: 25,

                ),

              ),

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

                        horizontal: 20,

                        vertical: 10,

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





                Text(


                  data["question"],



                  textAlign:

                      TextAlign.center,



                  style:

                      const TextStyle(


                    fontSize:

                        27,


                    fontWeight:

                        FontWeight.bold,


                  ),


                ),






                const SizedBox(

                  height: 20,

                ),







                Container(


                  width:

                      170,


                  height:

                      170,



                  decoration:

                      BoxDecoration(


                    color:

                        Colors.white,


                    borderRadius:

                        BorderRadius.circular(

                          30,

                        ),



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


                      data["answer"],



                      style:

                          const TextStyle(

                        fontSize:

                            100,


                        fontWeight:

                            FontWeight.bold,


                        color:

                            Colors.blue,


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

                          1.5,


                    ),





                    itemBuilder:

                        (context, index) {



                      final String letter =

                          data["options"][index];





                      return InkWell(



                        onTap:

                            answering

                                ? null

                                : () {


                              checkAnswer(

                                letter,

                              );


                            },





                        borderRadius:

                            BorderRadius.circular(25),





                        child: Container(



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

                                    6,

                                offset:

                                    Offset(0,3),

                              ),


                            ],


                          ),





                          child: Center(



                            child: Text(



                              letter,



                              style:

                                  const TextStyle(



                                fontSize:

                                    55,



                                fontWeight:

                                    FontWeight.bold,



                                color:

                                    Colors.blue,



                              ),



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

                        8,



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
