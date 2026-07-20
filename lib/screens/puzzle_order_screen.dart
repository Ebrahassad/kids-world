import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'games_screen.dart';
import '../progress_manager.dart';



class PuzzleOrderScreen extends StatefulWidget {

  const PuzzleOrderScreen({
    super.key,
  });


  @override
  State<PuzzleOrderScreen> createState() =>
      _PuzzleOrderScreenState();

}




class _PuzzleOrderScreenState
    extends State<PuzzleOrderScreen> {



  static const String gameName =
      "puzzle_order";



  final AudioPlayer audioPlayer =
      AudioPlayer();



  final Random random =
      Random();




  int stars = 0;


  int attempts = 0;



  bool checking = false;


  bool finished = false;





  final List<String> startPieces = [


    "🐑",
    "🌳",
    "☀️",
    "🏠",


  ];





  final List<String> correctOrder = [


    "☀️",
    "🌳",
    "🏠",
    "🐑",


  ];





  late List<String> pieces;







@override
void initState() {

  super.initState();

  loadProgress();

}


Future<void> loadProgress() async {

  final savedStars =
      await ProgressManager.getStars(
        gameName,
      );

  if(!mounted) return;

  setState(() {

    stars = savedStars;

    shufflePieces();

    attempts = 0;

    checking = false;

    finished = false;

  });

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








  Future<void> playCorrectAndWinSound()
  async {


    await playSound("correct.mp3");

await Future.delayed(
  const Duration(milliseconds:300),
);

await playSound("win.mp3");

  }








  void shufflePieces(){

  pieces = List<String>.from(startPieces);

  do {

    pieces.shuffle(random);

  } while (
    pieces.toString() ==
    correctOrder.toString()
  );

  finished = false;

}



  








  void restartGame(){


    setState(() {

  shufflePieces();

  

  attempts = 0;

  checking = false;

});


  }








  Future<void> checkPuzzle() async {


    if(checking || finished) return;



    setState(() {

  checking = true;

  attempts++;

});





    final bool isCorrect =

        pieces.toString() ==
            correctOrder.toString();





    if(isCorrect){

if(stars == 0){
  stars = 1;
}

  setState(() {

    finished = true;

  });


  


  await ProgressManager.saveStars(
    gameName,
    stars,
  );


  await ProgressManager.saveCompletedGame(
    gameName,
  );


  await ProgressManager.saveCompletedLevel(
    gameName,
    1,
  );


  await ProgressManager.addWinCount(
    gameName,
  );


  await ProgressManager.saveLastPlayed(
    gameName,
  );




      await playCorrectAndWinSound();





      await Future.delayed(

        const Duration(

          milliseconds: 500,

        ),

      );





      if(!mounted) return;





      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) => WinScreen(

            stars: stars,

gameId:
9,
            nextGame:

                const PuzzleOrderScreen(),



            gamesPage:

                const GamesScreen(),



            hasLevels:

                false,


          ),

        ),

      );




    }else{



      await playSound(

        "wrong.mp3",

      );



      if(mounted){


        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(

            content:

            Text(

              "❌ رتب الصورة بشكل صحيح",

            ),


            backgroundColor:

            Colors.red,

          ),

        );


      }



      setState(() {


        checking = false;


      });


    }


  }
@override
Widget build(BuildContext context) {

  return Scaffold(

    backgroundColor:
        Colors.lightBlue.shade50,


    appBar: AppBar(

      backgroundColor:
          Colors.blue,

      centerTitle:
          true,


      leading:
          IconButton(

        icon:
            const Icon(
              Icons.arrow_back,
            ),


        onPressed: () {

          Navigator.pop(context);

        },

      ),


      title:
          const Text(

        "رتّب الصورة 🧩",

        style:
            TextStyle(

          color:
              Colors.white,

          fontWeight:
              FontWeight.bold,

          fontSize:
              22,

        ),

      ),



      actions: [

        Padding(

          padding:
              const EdgeInsets.only(
                right: 15,
              ),


          child:
              Row(

            children: [


              const Icon(

                Icons.star,

                color:
                    Colors.yellow,

                size:
                    30,

              ),



              const SizedBox(
                width: 5,
              ),



              Text(

                "$stars",

                style:
                    const TextStyle(

                  color:
                      Colors.white,

                  fontSize:
                      22,

                  fontWeight:
                      FontWeight.bold,

                ),

              ),


            ],

          ),

        ),

      ],


    ),



    body:

    SafeArea(

      child:

      Padding(

        padding:
            const EdgeInsets.all(20),


        child:

        Column(

          children: [


            const Text(

              "اسحب القطع حتى تصبح الصورة صحيحة ⭐",

              textAlign:
                  TextAlign.center,


              style:

              TextStyle(

                fontSize:
                    25,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(

              height:

              20,

            ),



            Container(

              padding:
                  const EdgeInsets.all(15),


              decoration:
                  BoxDecoration(

                color:
                    Colors.white,

                borderRadius:
                    BorderRadius.circular(
                      20,
                    ),

                boxShadow: const [

                  BoxShadow(

                    color:
                        Colors.black12,

                    blurRadius:
                        8,

                    offset:
                        Offset(0,4),

                  ),

                ],

              ),


              child:

              const Text(

                "🧩 رتب المشهد من الأعلى إلى الأسفل",

                textAlign:
                    TextAlign.center,


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

              height:
                  20,

            ),



            Expanded(

              child:

              ReorderableListView(

                buildDefaultDragHandles:
                    false,


                onReorder:

                (oldIndex,newIndex){


                  if(finished) return;


                  setState((){


                    if(newIndex > oldIndex){

                      newIndex--;

                    }



                    final item =
                    pieces.removeAt(
                      oldIndex,
                    );


                    pieces.insert(

                      newIndex,

                      item,

                    );


                  });


                },



                children: [


                  for(int i=0;
                  i<pieces.length;
                  i++)


                    Card(

                      key:

                      ValueKey(
                        pieces[i],
                      ),



                      elevation:
                          6,



                      margin:

                      const EdgeInsets.symmetric(
                        vertical: 8,
                      ),



                      shape:

                      RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                              20,
                            ),

                      ),



                      child:

                      ListTile(

                        leading:

                        ReorderableDragStartListener(

                          index:
                              i,

                          child:

                          const Icon(

                            Icons.drag_handle,

                            color:
                                Colors.blue,

                            size:
                                35,

                          ),

                        ),



                        title:

                        Text(

                          pieces[i],

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


                ],

              ),

            ),
            const SizedBox(

              height:
                  15,

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

                "🎯 المحاولات: $attempts",

                style:

                const TextStyle(

                  fontSize:
                      20,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.blue,

                ),

              ),



            ),





            const SizedBox(

              height:
                  20,

            ),





            SizedBox(

              width:
                  double.infinity,


              child:

              ElevatedButton.icon(



                onPressed:

                checking || finished

                    ? null

                    : checkPuzzle,



                icon:

                Icon(

                  finished

                      ? Icons.done_all

                      : Icons.check_circle,

                  size:
                      30,

                ),




                label:

                Text(

                  finished

                      ? "تم الإنجاز 🎉"

                      : checking

                      ? "جاري التحقق..."

                      : "تحقق من الترتيب ✅",



                  style:

                  const TextStyle(

                    fontSize:
                        22,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),



                style:

                ElevatedButton.styleFrom(



                  backgroundColor:

                  finished

                      ? Colors.orange

                      : Colors.green,



                  foregroundColor:

                  Colors.white,



                  padding:

                  const EdgeInsets.symmetric(

                    vertical:
                        15,

                  ),



                  shape:

                  RoundedRectangleBorder(

                    borderRadius:

                    BorderRadius.circular(

                      25,

                    ),

                  ),



                  elevation:
                      8,


                ),



              ),

            ),





            const SizedBox(

              height:
                  15,

            ),





            SizedBox(

              width:
                  double.infinity,


              child:

              OutlinedButton.icon(



                onPressed:

                restartGame,



                icon:

                const Icon(

                  Icons.refresh,

                  size:
                      28,

                ),




                label:

                const Text(

                  "إعادة اللعب 🔄",

                  style:

                  TextStyle(

                    fontSize:
                        21,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),



                style:

                OutlinedButton.styleFrom(



                  foregroundColor:
                      Colors.blue,


                  backgroundColor:
                      Colors.white,



                  padding:

                  const EdgeInsets.symmetric(

                    vertical:
                        13,

                  ),



                  shape:

                  RoundedRectangleBorder(

                    borderRadius:

                    BorderRadius.circular(

                      25,

                    ),

                  ),



                  side:

                  const BorderSide(

                    color:
                        Colors.blue,

                    width:
                        2,

                  ),


                ),



              ),

            ),





          ],


        ),

      ),

    ),

  );

}






@override
void dispose() {


  audioPlayer.dispose();


  super.dispose();


}

}
