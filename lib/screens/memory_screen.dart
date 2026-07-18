import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'memory_levels_screen.dart';
import 'progress_manager.dart';


class MemoryGameScreen extends StatefulWidget {

  final int level;

  const MemoryGameScreen({
    super.key,
    required this.level,
  });


  @override
  State<MemoryGameScreen> createState() =>
      _MemoryGameScreenState();

}



class _MemoryGameScreenState
    extends State<MemoryGameScreen> {


  static const String gameName =
      "memory_game";


  final AudioPlayer audioPlayer =
      AudioPlayer();


  final Random random =
      Random();



  final List<String> animalsList = [


    "🐶",
    "🐱",
    "🐭",
    "🐹",
    "🐰",
    "🦊",
    "🐻",
    "🐼",
    "🐨",
    "🐯",
    "🦁",
    "🐮",
    "🐷",
    "🐸",
    "🐵",
    "🐔",
    "🦆",
    "🦉",
    "🐢",
    "🐙",
    "🐠",
    "🐬",
    "🦋",
    "🐞",

  ];



  late List<String> levelAnimals;



  List<Map<String, dynamic>> cards = [];



  int stars = 0;

  int matches = 0;



  int? firstCard;

  int? secondCard;



  bool checking = false;



  @override
  void initState() {

    super.initState();

    startGame();

  }





  void startGame() {


    int pairs;



    switch(widget.level){


      case 1:
        pairs = 4;
        break;


      case 2:
        pairs = 5;
        break;


      case 3:
        pairs = 6;
        break;


      case 4:
        pairs = 7;
        break;


      case 5:
        pairs = 8;
        break;


      case 6:
        pairs = 9;
        break;


      case 7:
        pairs = 10;
        break;


      case 8:
        pairs = 11;
        break;


      case 9:
      case 10:
        pairs = 12;
        break;


      default:
        pairs = 4;

    }



    levelAnimals =
        animalsList.take(pairs).toList();



    final List<Map<String,dynamic>> newCards = [];



    for(final animal in levelAnimals){


      newCards.add({

        "image": animal,

        "open": false,

        "done": false,

      });



      newCards.add({

        "image": animal,

        "open": false,

        "done": false,

      });


    }



    newCards.shuffle(random);



    setState(() {


      cards = newCards;


      stars = 0;


      matches = 0;


      firstCard = null;


      secondCard = null;


      checking = false;


    });


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







  void selectCard(int index) {



    if(checking) return;



    if(cards[index]["open"] ||
       cards[index]["done"]) {

      return;

    }




    setState(() {


      cards[index]["open"] = true;


    });





    if(firstCard == null){


      firstCard = index;


    }else{



      secondCard = index;


      checking = true;



      Future.delayed(


        const Duration(
          milliseconds: 800,
        ),


        checkMatch,


      );



    }



  }






  void checkMatch(){



    if(!mounted) return;



    if(firstCard == null ||
       secondCard == null){

      return;

    }



    final first =
        cards[firstCard!]["image"];



    final second =
        cards[secondCard!]["image"];





    if(first == second){



      playSound(
        "correct.mp3",
      );



      setState((){


        cards[firstCard!]["done"] =
            true;


        cards[secondCard!]["done"] =
            true;



        stars++;


        matches++;


      });




      if(matches == levelAnimals.length){


        Future.delayed(


          const Duration(
            milliseconds: 700,
          ),


          () async {



            if(widget.level < 10){


              await ProgressManager
                  .saveUnlockedLevel(

                gameName,

                widget.level + 1,

              );


            }



            await ProgressManager
                .saveCompletedGame(

              gameName,

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

                      MemoryGameScreen(

                    level: widget.level,

                  ),



                  gamesPage:

                      const MemoryLevelsScreen(),



                  hasLevels: true,



                  currentLevel:
                      widget.level,



                  maxLevels:
                      10,



                  nextLevelPage:

                      widget.level < 10

                      ?

                      MemoryGameScreen(

                        level:
                            widget.level + 1,

                      )

                      :

                      null,



                ),


              ),


            );



          },


        );


      }



    }else{



      playSound(
        "wrong.mp3",
      );



      setState((){


        cards[firstCard!]["open"] =
            false;



        cards[secondCard!]["open"] =
            false;



      });


    }





    firstCard = null;


    secondCard = null;


    checking = false;



  }






  void restartGame(){



    startGame();



  }





  int getColumns(){



    if(widget.level <= 2){

      return 4;

    }


    if(widget.level <= 5){

      return 5;

    }


    if(widget.level <= 8){

      return 6;

    }


    return 7;


  }






  double getEmojiSize(){



    if(widget.level <= 2){

      return 55;

    }



    if(widget.level <= 5){

      return 48;

    }



    if(widget.level <= 8){

      return 40;

    }



    return 35;


  }
  Widget buildCard(int index) {


    final bool show =

        cards[index]["open"] ||

        cards[index]["done"];




    return GestureDetector(


      onTap: () {


        selectCard(index);


      },



      child: AnimatedContainer(


        duration:

            const Duration(

              milliseconds: 300,

            ),



        decoration: BoxDecoration(


          color:

              show

                  ? Colors.white

                  : Colors.green,



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




        child: Center(



          child: Text(



            show

                ? cards[index]["image"]

                : "❓",



            style:

                TextStyle(

              fontSize:

                  getEmojiSize(),

            ),



          ),


        ),



      ),



    );


  }







  @override
  Widget build(BuildContext context) {


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



                        "🧩 $matches/${levelAnimals.length}",



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



                  "لعبة الذاكرة المستوى ${widget.level} 🧠",



                  style:

                      const TextStyle(



                    fontSize:

                        28,



                    fontWeight:

                        FontWeight.bold,



                  ),



                ),







                const SizedBox(

                  height: 10,

                ),





                const Text(



                  "ابحث عن الصور المتشابهة 🎯",



                  style:

                      TextStyle(



                    fontSize:

                        20,



                    fontWeight:

                        FontWeight.bold,



                  ),



                ),







                const SizedBox(

                  height: 15,

                ),






                Expanded(



                  child:

                      GridView.builder(



                    padding:

                        const EdgeInsets.all(20),




                    itemCount:

                        cards.length,





                    gridDelegate:

                        SliverGridDelegateWithFixedCrossAxisCount(



                      crossAxisCount:

                          getColumns(),




                      crossAxisSpacing:

                          12,



                      mainAxisSpacing:

                          12,



                    ),





                    itemBuilder:

                        (context,index){



                      return buildCard(index);



                    },



                  ),



                ),
                ElevatedButton.icon(



                  onPressed:

                      restartGame,



                  icon:

                      const Icon(

                    Icons.refresh_rounded,

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

  void dispose(){



    audioPlayer.stop();



    audioPlayer.dispose();



    super.dispose();



  }


}