import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'memory_levels_screen.dart';
import '../progress_manager.dart';


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


  List<Map<String,dynamic>> cards = [];



  int stars = 0;


  int matches = 0;


  int attempts = 0;



  int? firstCard;


  int? secondCard;



  bool checking = false;


  bool loading = true;







  @override
  void initState(){

    super.initState();


    loadGame();

  }








  Future<void> loadGame() async {


    startGame();



    if(mounted){


      setState((){


        loading = false;


      });


    }


  }








  int getPairsCount(){


    switch(widget.level){


      case 1:
        return 4;


      case 2:
        return 5;


      case 3:
        return 6;


      case 4:
        return 7;


      case 5:
        return 8;


      case 6:
        return 9;


      case 7:
        return 10;


      case 8:
        return 11;


      case 9:
      case 10:
        return 12;


      default:

        return 4;

    }


  }








  void startGame(){


    final pairs =
        getPairsCount();



    levelAnimals =
        List<String>.from(
          animalsList,
        )
          ..shuffle(random);



    levelAnimals =
        levelAnimals
            .take(pairs)
            .toList();




    final List<Map<String,dynamic>>
        newCards = [];




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



    cards = newCards;


    stars = 0;


    matches = 0;


    attempts = 0;


    firstCard = null;


    secondCard = null;


    checking = false;



  }
  Future<void> playSound(
    String fileName,
  ) async {


    try {


      await audioPlayer.stop();



      await audioPlayer.play(


        AssetSource(

          "sounds/$fileName",

        ),


      );



    } catch(e) {


      debugPrint(

        "خطأ تشغيل الصوت: $e",

      );


    }


  }








  void selectCard(
    int index,
  ){



    if(checking) return;



    if(cards[index]["open"] == true ||
       cards[index]["done"] == true){

      return;

    }






    setState((){


      cards[index]["open"] = true;


    });






    if(firstCard == null){


      firstCard = index;



    }else{



      secondCard = index;



      checking = true;


      attempts++;




      Future.delayed(


        const Duration(

          milliseconds: 900,

        ),


        checkMatch,


      );


    }



  }










  Future<void> checkMatch() async {



    if(!mounted) return;



    if(firstCard == null ||
       secondCard == null){


      checking = false;

      return;


    }





    final firstIndex =
        firstCard!;


    final secondIndex =
        secondCard!;






    final firstImage =
        cards[firstIndex]["image"];



    final secondImage =
        cards[secondIndex]["image"];







    if(firstImage == secondImage){



      await playSound(

        "correct.mp3",

      );





      setState((){



        cards[firstIndex]["done"] =
            true;



        cards[secondIndex]["done"] =
            true;



        matches++;



        stars++;



      });







      if(matches ==
          levelAnimals.length){



        await finishLevel();



      }






    }else{



      await playSound(

        "wrong.mp3",

      );




      await Future.delayed(

        const Duration(

          milliseconds: 300,

        ),

      );





      if(mounted){



        setState((){



          cards[firstIndex]["open"] =
              false;



          cards[secondIndex]["open"] =
              false;



        });



      }



    }






    firstCard = null;


    secondCard = null;


    checking = false;



  }









  Future<void> finishLevel() async {



    await ProgressManager.saveStars(

      gameName,

      stars,

    );





    await ProgressManager.saveCompletedLevel(

      gameName,

      widget.level,

    );






    if(widget.level < 10){


      await ProgressManager.saveUnlockedLevel(

        gameName,

        widget.level + 1,

      );


    }






    if(widget.level == 10){
  await ProgressManager.saveCompletedGame(
    gameName,
  );
}






    // الإضافات الجديدة

    



    await ProgressManager.addWinCount(

      gameName,

    );



    await ProgressManager.saveLastPlayed(

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



gameId:
7,

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

                  ? MemoryGameScreen(

                      level:

                          widget.level + 1,

                    )

                  : null,



        ),



      ),



    );



  }








  void restartGame(){


    setState((){


      startGame();


    });


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









  Widget buildCard(
    int index,
  ){


    final bool show =

        cards[index]["open"] == true ||

        cards[index]["done"] == true;






    return GestureDetector(



      onTap: (){


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






        child: Center(



          child: AnimatedSwitcher(



            duration:

                const Duration(

                  milliseconds: 250,

                ),





            child: Text(



              show

                  ? cards[index]["image"]

                  : "❓",





              key:

                  ValueKey(show),





              style:

                  TextStyle(



                fontSize:

                    getEmojiSize(),



              ),



            ),



          ),



        ),




      ),



    );



  }












  @override
  Widget build(BuildContext context){



    if(loading){


      return const Scaffold(



        body: Center(



          child:

              CircularProgressIndicator(),



        ),



      );


    }






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

              Colors.white.withOpacity(

                0.25,

              ),







          child: SafeArea(



            child: Column(



              children: [



                Row(



                  children: [




                    IconButton(



                      icon:

                          const Icon(



                        Icons.arrow_back,



                        size:

                            32,



                      ),




                      onPressed: (){


                        Navigator.pop(context);



                      },



                    ),






                    Expanded(



                      child: Text(



                        "لعبة الذاكرة 🧠 المستوى ${widget.level}",




                        textAlign:

                            TextAlign.center,





                        style:

                            const TextStyle(



                          fontSize:

                              24,



                          fontWeight:

                              FontWeight.bold,



                        ),




                      ),




                    ),





                    const SizedBox(

                      width:

                          45,

                    ),





                  ],



                ),







                const SizedBox(

                  height:

                      15,

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

                              25,



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



                        "🎯 المحاولات $attempts",




                        style:

                            const TextStyle(



                          fontSize:

                              20,



                          fontWeight:

                              FontWeight.bold,



                        ),



                      ),



                    ),



                  ],



                ),
                const SizedBox(

                  height:

                      20,

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



                      childAspectRatio:

                          1,



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

                          BorderRadius.circular(

                            25,

                          ),



                    ),





                  ),





                ),







                const SizedBox(

                  height:

                      20,

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
