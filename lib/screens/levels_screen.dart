import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  int stars = 0;
  int matches = 0;

  int? firstCard;
  int? secondCard;

  bool checking = false;


  List<Map<String, dynamic>> cards = [];


  @override
  void initState() {
    super.initState();
    startGame();
  }


  void startGame() {

    List<String> images = [

      "🐶",
      "🐱",
      "🐮",
      "🐑",
      "🦁",
      "🐼",

    ];


    List<String> allCards = [

      ...images,
      ...images,

    ];


    allCards.shuffle(Random());


    cards = allCards.map((e) {

      return {

        "image": e,
        "open": false,
        "done": false,

      };

    }).toList();


    stars = 0;
    matches = 0;

    firstCard = null;
    secondCard = null;

    setState(() {});

  }



  void playSound(String file) {

    audioPlayer.play(
      AssetSource('sounds/$file'),
    );

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
        const Duration(seconds: 1),
        checkMatch,
      );

    }

  }



  void checkMatch(){


    if(cards[firstCard!]["image"] ==
       cards[secondCard!]["image"]){


      playSound("correct.mp3");


      setState(() {

        cards[firstCard!]["done"] = true;

        cards[secondCard!]["done"] = true;

        stars++;

        matches++;

      });


      if(matches == cards.length ~/ 2){


        Future.delayed(

          const Duration(milliseconds:500),

          (){

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (_) =>
                const WinScreen(),

              ),

            );

          },

        );


      }


    }else{


      playSound("wrong.mp3");


      setState(() {

        cards[firstCard!]["open"] = false;

        cards[secondCard!]["open"] = false;

      });


    }


    firstCard = null;

    secondCard = null;

    checking = false;

  }



  @override
  void dispose(){

    audioPlayer.dispose();

    super.dispose();

  }



  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor: Colors.lightBlue.shade50,


      appBar: AppBar(

        backgroundColor: Colors.blue,

        centerTitle:true,


        title: const Text(

          "لعبة الذاكرة 🧠⭐",

          style: TextStyle(

            color: Colors.white,

            fontWeight: FontWeight.bold,

          ),

        ),


        actions:[


          IconButton(

            onPressed:startGame,

            icon:const Icon(

              Icons.refresh,

              color:Colors.white,

            ),

          ),


          Padding(

            padding:
            const EdgeInsets.only(right:15),


            child:Row(

              children:[

                const Icon(

                  Icons.star,

                  color:Colors.yellow,

                ),


                Text(

                  "$stars",

                  style:const TextStyle(

                    color:Colors.white,

                    fontSize:20,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),

              ],

            ),

          )

        ],

      ),



      body:Padding(

        padding:
        const EdgeInsets.all(20),


        child:Column(

          children:[


            const Text(

              "ابحث عن الصور المتشابهة 🐾",

              style:TextStyle(

                fontSize:26,

                fontWeight:
                FontWeight.bold,

              ),

            ),


            const SizedBox(height:25),



            Expanded(

              child:GridView.builder(

                itemCount:cards.length,


                gridDelegate:

                const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount:3,

                  crossAxisSpacing:15,

                  mainAxisSpacing:15,

                ),


                itemBuilder:(context,index){


                  bool show =
                  cards[index]["open"] ||
                  cards[index]["done"];


                  return GestureDetector(

                    onTap:(){

                      selectCard(index);

                    },


                    child:Container(

                      decoration:BoxDecoration(

                        color:show
                            ? Colors.white
                            : Colors.green,


                        borderRadius:
                        BorderRadius.circular(20),


                        boxShadow:[

                          BoxShadow(

                            color:
                            Colors.black26,

                            blurRadius:5,

                          )

                        ]

                      ),


                      child:Center(

                        child:Text(

                          show
                          ? cards[index]["image"]
                          : "❓",


                          style:const TextStyle(

                            fontSize:45,

                          ),

                        ),

                      ),

                    ),

                  );


                },

              ),

            ),


          ],

        ),

      ),

    );

  }

}