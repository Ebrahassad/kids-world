import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';
import 'games_screen.dart';
import 'progress_manager.dart';


class PuzzleOrderScreen extends StatefulWidget {

  const PuzzleOrderScreen({super.key});


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



  int stars = 0;


  bool checking = false;



  List<String> pieces = [

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





  Future<void> checkPuzzle() async {


    if(checking) return;


    setState(() {

      checking = true;

    });




    if(pieces.toString() ==
        correctOrder.toString()) {



      await playSound(
        "correct.mp3",
      );



      setState(() {

        stars = 1;

      });




      await ProgressManager.saveStars(

        gameName,

        stars,

      );




      await ProgressManager.saveCompletedGame(

        gameName,

      );





      await Future.delayed(

        const Duration(
          milliseconds: 700,
        ),

      );




      if(!mounted) return;




      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) => WinScreen(

            stars: stars,

            nextGame:
                const PuzzleOrderScreen(),

            gamesPage:
                const GamesScreen(),

          ),

        ),

      );




    } else {



      await playSound(

        "wrong.mp3",

      );



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



      setState(() {

        checking = false;

      });


    }


  }






  void restartGame(){


    setState(() {


      pieces = [

        "🐑",
        "🌳",
        "☀️",
        "🏠",

      ];

      stars = 0;

      checking = false;


    });


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


        title:
            const Text(

          "رتّب الصورة ⭐",

          style:
              TextStyle(

            color:
                Colors.white,

            fontWeight:
                FontWeight.bold,

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

                ),


                const SizedBox(
                  width:5,
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
          Padding(


        padding:
            const EdgeInsets.all(20),



        child:
            Column(


          children: [



            const Text(

              "اسحب القطع ورتب الصورة 🧩",

              style:
                  TextStyle(

                fontSize:
                    28,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(
              height:25,
            ),




            Expanded(


              child:
                  ReorderableListView(



                onReorder:
                    (oldIndex,newIndex){


                  setState(() {


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


                  for(int i=0;i<pieces.length;i++)

                    Card(


                      key:
                          ValueKey(
                            pieces[i],
                          ),


                      elevation:
                          5,


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
                            const Icon(

                          Icons.drag_handle,

                          color:
                              Colors.blue,

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
              height:20,
            ),




            ElevatedButton(



              onPressed:
                  checking
                      ? null
                      : checkPuzzle,



              style:
                  ElevatedButton.styleFrom(



                backgroundColor:
                    Colors.green,



                padding:
                    const EdgeInsets.symmetric(

                  horizontal:
                      50,

                  vertical:
                      15,

                ),



                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(
                        20,
                      ),

                ),



              ),



              child:
                  const Text(



                "تحقق ✅",



                style:
                    TextStyle(

                  fontSize:
                      25,

                  color:
                      Colors.white,

                  fontWeight:
                      FontWeight.bold,

                ),


              ),



            ),




            const SizedBox(
              height:15,
            ),




            TextButton(

              onPressed:
                  restartGame,


              child:
                  const Text(

                "إعادة اللعب 🔄",

                style:
                    TextStyle(

                  fontSize:
                      20,

                ),

              ),

            ),



          ],


        ),


      ),


    );


  }





  @override
  void dispose(){


    audioPlayer.dispose();


    super.dispose();


  }


}