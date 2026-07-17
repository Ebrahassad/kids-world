import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'win_screen.dart';


class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() =>
      _MemoryGameScreenState();
}


class _MemoryGameScreenState extends State<MemoryGameScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  final Random random = Random();


  final List<String> animals = [

    "🐶",
    "🐱",
    "🐮",
    "🐑",
    "🦁",
    "🐸",

  ];


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

  final List<Map<String, dynamic>> newCards = [];


  for (String animal in animals) {

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


  // خلط الكروت عشوائياً
  newCards.shuffle(random);



  if (!mounted) return;

setState(() {

    cards = newCards;

    stars = 0;

    matches = 0;

    firstCard = null;

    secondCard = null;

    checking = false;

  });

}


  Future<void> playSound(String file) async {

    try {

      await audioPlayer.stop();


      await audioPlayer.play(

        AssetSource(
          "sounds/$file",
        ),

      );


    } catch(e) {

      debugPrint(
        "خطأ الصوت: $e",
      );

    }

  }
  void selectCard(int index) {

if (cards.isEmpty) return;

    // منع الضغط أثناء المقارنة
    if (checking) return;


    // منع فتح بطاقة مكتملة أو مفتوحة
    if (cards[index]["open"] == true ||
        cards[index]["done"] == true) {

      return;

    }



    setState(() {

      cards[index]["open"] = true;

    });



    if (firstCard == null) {

      firstCard = index;


    } else {


      secondCard = index;


      checking = true;


      Future.delayed(

        const Duration(seconds: 1),

        () {

          checkMatch();

        },

      );

    }

  }




  void checkMatch() {

  if (!mounted) return;

  if (firstCard == null ||
      secondCard == null) {
    return;
  }


   
    final first =
        cards[firstCard!]["image"];


    final second =
        cards[secondCard!]["image"];




    if (first == second) {


      playSound("correct.mp3");



      setState(() {


        cards[firstCard!]["done"] = true;


        cards[secondCard!]["done"] = true;



        stars++;

        matches++;

      });



      if (matches == animals.length) {


        Future.delayed(

          const Duration(milliseconds: 700),

          () {


         if (!mounted) return;

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (_) => WinScreen(

                  stars: stars,

                ),

              ),

            );


          },

        );

      }



    } else {


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




  Widget buildCard(int index) {


    bool show =

        cards[index]["open"] ||

        cards[index]["done"];



    return GestureDetector(


      onTap: () {

        selectCard(index);

      },



      child: AnimatedContainer(


        duration:

            const Duration(milliseconds: 300),



        decoration: BoxDecoration(


          color: show

              ? Colors.white

              : Colors.green,



          borderRadius:

              BorderRadius.circular(25),



          boxShadow: const [


            BoxShadow(

              color: Colors.black26,

              blurRadius: 8,

              offset: Offset(0,4),

            ),

          ],

        ),



        child: Center(


          child: AnimatedSwitcher(


            duration:

                const Duration(milliseconds: 300),



            child: Text(


              show

                  ? cards[index]["image"]

                  : "❓",



              key:

                  ValueKey(show),



              style: const TextStyle(

                fontSize: 55,

              ),

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

          color: Colors.white.withOpacity(0.25),


          child: SafeArea(

            child: Column(

              children: [


                const SizedBox(height: 15),



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


                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                        boxShadow: const [

                          BoxShadow(

                            color: Colors.black12,

                            blurRadius: 6,

                          ),

                        ],

                      ),



                      child: Text(

                        "⭐ $stars",


                        style: const TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,

                          color: Colors.orange,

                        ),

                      ),

                    ),





                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 20,

                        vertical: 10,

                      ),


                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                      ),



                      child: Text(

                        "🧩 $matches/${animals.length}",


                        style: const TextStyle(

                          fontSize: 22,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ),



                  ],

                ),




                const SizedBox(height: 25),




                const Text(

                  "لعبة الذاكرة 🧠",

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),




                const SizedBox(height: 10),



                const Text(

                  "ابحث عن الصور المتشابهة 🎯",

                  style: TextStyle(

                    fontSize: 22,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),




                const SizedBox(height: 20),




                Expanded(


                  child: GridView.builder(


                    padding:
                        const EdgeInsets.all(20),



                    itemCount:
                        cards.length,



                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(


                      crossAxisCount: 4,


                      crossAxisSpacing: 12,


                      mainAxisSpacing: 12,


                    ),



                    itemBuilder:
                        (context,index){


                      return buildCard(index);


                    },


                  ),


                ),




                ElevatedButton.icon(


                  onPressed: () {
  startGame();
},



                  icon: const Icon(

                    Icons.refresh_rounded,

                  ),



                  label: const Text(

                    "إعادة اللعب",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),



                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.white,

                    foregroundColor: Colors.blue,

                    elevation: 8,

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 35,

                      vertical: 12,

                    ),



                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(25),

                    ),

                  ),

                ),




                const SizedBox(height: 20),


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