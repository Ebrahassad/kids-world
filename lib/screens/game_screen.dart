import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'games_screen.dart';
import '../progress_manager.dart';

class GameScreen extends StatefulWidget {

  const GameScreen({super.key});


  @override
  State<GameScreen> createState() =>
      _GameScreenState();

}



class _GameScreenState extends State<GameScreen> {


  static const String gameName =
      "puzzle_game";


  final AudioPlayer audioPlayer =
      AudioPlayer();


  final Random random =
      Random();



  int currentQuestion = 0;

  int stars = 0;


  bool loading = true;

  bool answering = false;


  bool showCorrect =
      false;




  final List<Map<String, dynamic>>
      originalQuestions = [


    {
      "image":
      "assets/images/Puzzle/kids_puzzle.png",

      "answer":
      "أطفال",

      "options":[
        "أطفال",
        "قرد",
        "أسد",
        "سمكة",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/monkey_puzzle.png",

      "answer":
      "قرد",

      "options":[
        "دب",
        "قرد",
        "قطة",
        "كلب",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/bear_puzzle.png",

      "answer":
      "دب",

      "options":[
        "سمكة",
        "دب",
        "أرنب",
        "أسد",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/fish_puzzle.png",

      "answer":
      "سمكة",

      "options":[
        "فراشة",
        "سمكة",
        "كلب",
        "ديناصور",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/dinosaur_puzzle.png",

      "answer":
      "ديناصور",

      "options":[
        "قرد",
        "ديناصور",
        "أسد",
        "دب",
      ],

    },
    {
      "image":
      "assets/images/Puzzle/butterfly_puzzle.png",

      "answer":
      "فراشة",

      "options":[
        "قطة",
        "كلب",
        "فراشة",
        "سمكة",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/dog_puzzle.png",

      "answer":
      "كلب",

      "options":[
        "كلب",
        "أرنب",
        "دب",
        "أسد",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/cat_puzzle.png",

      "answer":
      "قطة",

      "options":[
        "قطة",
        "سمكة",
        "قرد",
        "ديناصور",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/rabbit_puzzle.png",

      "answer":
      "أرنب",

      "options":[
        "فراشة",
        "كلب",
        "أرنب",
        "أسد",
      ],

    },


    {
      "image":
      "assets/images/Puzzle/lion_puzzle.png",

      "answer":
      "أسد",

      "options":[
        "دب",
        "أسد",
        "قطة",
        "سمكة",
      ],

    },


  ];



  late List<Map<String,dynamic>> questions;




  @override
  void initState(){

    super.initState();


    prepareGame();


    loadProgress();

  }





  void prepareGame(){


    questions =
        originalQuestions.map((item){


      return {


        "image":
        item["image"],


        "answer":
        item["answer"],



        "options":
        List<String>.from(

          item["options"],

        ),



      };


    }).toList();




    questions.shuffle(random);




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
  Future<void> checkAnswer(String answer) async {


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

        showCorrect = true;


      });



      await ProgressManager.saveStars(

        gameName,

        stars,

      );




      ScaffoldMessenger.of(context)
          .showSnackBar(


        const SnackBar(

          content:

          Text(
            "🎉 إجابة صحيحة ⭐",
          ),


          backgroundColor:
          Colors.green,


          duration:

          Duration(
            milliseconds: 700,
          ),

        ),


      );




      await Future.delayed(

        const Duration(
          milliseconds: 800,
        ),

      );



      if(!mounted) return;




      if(currentQuestion <
          questions.length - 1){



        setState((){


          currentQuestion++;


          answering = false;


          showCorrect = false;



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



              stars:
              stars,



              nextGame:
              const GameScreen(),



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

            "❌ حاول مرة أخرى",

          ),


          backgroundColor:

          Colors.red,



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




      if(mounted){


        setState((){


          answering = false;


        });


      }



    }



  }






  void restartGame(){


    audioPlayer.stop();



    prepareGame();




    setState((){


      currentQuestion = 0;


      stars = 0;


      answering = false;


      showCorrect = false;



    });




    ProgressManager.resetProgress(

      gameName,

    );


  }







  @override
  Widget build(BuildContext context){



    if(loading){


      return const Scaffold(

        body:

        Center(

          child:

          CircularProgressIndicator(),

        ),

      );


    }





    if(questions.isEmpty){


      return const Scaffold(

        body:

        Center(

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


                const SizedBox(height:15),



                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,


                  children: [


                    _infoBox(
                      "⭐ $stars",
                      Colors.orange,
                    ),



                    _infoBox(

                      "${currentQuestion + 1}/${questions.length}",

                      Colors.blue,

                    ),


                  ],

                ),



                const SizedBox(height:20),




                Container(

                  margin:
                  const EdgeInsets.symmetric(
                    horizontal:20,
                  ),


                  padding:
                  const EdgeInsets.all(15),



                  decoration: BoxDecoration(

                    color:
                    Colors.white,


                    borderRadius:
                    BorderRadius.circular(25),


                  ),



                  child: Stack(


                    alignment:
                    Alignment.center,


                    children: [



                      Image.asset(

                        data["image"],


                        height:

                        MediaQuery.of(context)
                            .size
                            .height *
                            0.30,


                        fit:
                        BoxFit.contain,

                      ),



                      if(showCorrect)

                        const Icon(

                          Icons.star,

                          color:
                          Colors.orange,

                          size:
                          80,

                        ),



                    ],



                  ),


                ),





                const SizedBox(height:20),





                const Text(

                  "اختر الصورة الصحيحة 🎯",

                  style:

                  TextStyle(

                    fontSize:25,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),





                const SizedBox(height:15),





                Expanded(

                  child: GridView.builder(


                    padding:
                    const EdgeInsets.all(20),



                    itemCount:
                    data["options"].length,



                    gridDelegate:

                    const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount:2,

                      crossAxisSpacing:15,

                      mainAxisSpacing:15,

                      childAspectRatio:2,

                    ),



                    itemBuilder:
                        (context,index){



                      final option =
                      data["options"][index];




                      return InkWell(


                        onTap:
                        answering
                            ? null
                            : (){


                          checkAnswer(

                            option,

                          );


                        },



                        borderRadius:
                        BorderRadius.circular(20),



                        child: Container(


                          alignment:
                          Alignment.center,



                          decoration:
                          BoxDecoration(


                            color:
                            Colors.white,



                            borderRadius:
                            BorderRadius.circular(20),



                            boxShadow:
                            const [

                              BoxShadow(

                                color:
                                Colors.black26,

                                blurRadius:
                                6,

                              ),

                            ],


                          ),




                          child: Text(

                            option,


                            style:

                            const TextStyle(

                              fontSize:22,

                              fontWeight:
                              FontWeight.bold,

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

                      fontSize:20,

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),



                  style:
                  ElevatedButton.styleFrom(


                    padding:
                    const EdgeInsets.symmetric(

                      horizontal:35,

                      vertical:12,

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






  Widget _infoBox(String text, Color color){


    return Container(


      padding:
      const EdgeInsets.symmetric(

        horizontal:20,

        vertical:10,

      ),



      decoration:
      BoxDecoration(

        color:
        Colors.white,


        borderRadius:
        BorderRadius.circular(20),


        boxShadow:
        const [

          BoxShadow(

            color:
            Colors.black12,

            blurRadius:
            6,

          ),

        ],

      ),



      child: Text(


        text,


        style:

        TextStyle(

          fontSize:24,

          fontWeight:
          FontWeight.bold,

          color:
          color,

        ),


      ),


    );


  }





  @override
  void dispose(){


    audioPlayer.stop();


    audioPlayer.dispose();



    super.dispose();


  }


}