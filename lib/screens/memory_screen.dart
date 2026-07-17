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

  List<Map<String, dynamic>> cards = [
    {
      "image": "🐶",
      "open": false,
      "done": false,
    },
    {
      "image": "🐶",
      "open": false,
      "done": false,
    },
    {
      "image": "🐱",
      "open": false,
      "done": false,
    },
    {
      "image": "🐱",
      "open": false,
      "done": false,
    },
    {
      "image": "🐮",
      "open": false,
      "done": false,
    },
    {
      "image": "🐮",
      "open": false,
      "done": false,
    },
    {
      "image": "🐑",
      "open": false,
      "done": false,
    },
    {
      "image": "🐑",
      "open": false,
      "done": false,
    },
  ];

  int? firstCard;
  int? secondCard;
  void playSound(String fileName) {
    audioPlayer.play(
      AssetSource('sounds/$fileName'),
    );
  }


  void selectCard(int index) {

    if (cards[index]["done"] == true ||
        cards[index]["open"] == true) {
      return;
    }


    setState(() {
      cards[index]["open"] = true;
    });


    if (firstCard == null) {

      firstCard = index;

    } else {

      secondCard = index;


      Future.delayed(
        const Duration(seconds: 1),
        () {

          checkMatch();

        },
      );

    }

  }


  void checkMatch() {

    if (cards[firstCard!]["image"] ==
        cards[secondCard!]["image"]) {


      playSound("correct.mp3");


      setState(() {

        cards[firstCard!]["done"] = true;
        cards[secondCard!]["done"] = true;

        stars++;
        matches++;

      });


      if (matches == cards.length ~/ 2) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WinScreen(),
          ),
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

  }


  @override
  void dispose() {

    audioPlayer.dispose();

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.lightBlue.shade50,


      appBar: AppBar(

        backgroundColor: Colors.blue,

        centerTitle: true,

        title: const Text(
          "لعبة الذاكرة ⭐",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 16),

            child: Row(

              children: [

                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),

                const SizedBox(width: 5),

                Text(
                  "$stars",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],

            ),

          ),

        ],

      ),


      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [


            const Text(
              "ابحث عن الصور المتشابهة",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 30),


            Expanded(

              child: GridView.builder(

                itemCount: cards.length,


                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,

                  crossAxisSpacing: 20,

                  mainAxisSpacing: 20,

                ),


                itemBuilder: (context, index) {


                  bool show =
                      cards[index]["open"] ||
                      cards[index]["done"];


                  return GestureDetector(

                    onTap: () {

                      selectCard(index);

                    },


                    child: Container(

                      decoration: BoxDecoration(

                        color: show
                            ? Colors.white
                            : Colors.green,

                        borderRadius:
                            BorderRadius.circular(20),

                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),

                      ),


                      child: Center(

                        child: Text(

                          show
                              ? cards[index]["image"]
                              : "❓",

                          style: const TextStyle(

                            fontSize: 50,

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