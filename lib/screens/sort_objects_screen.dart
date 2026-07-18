import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';
import 'games_screen.dart';

import '../progress_manager.dart';

class SortObjectsScreen extends StatefulWidget {
  const SortObjectsScreen({super.key});

  @override
  State<SortObjectsScreen> createState() => _SortObjectsScreenState();
}

class _SortObjectsScreenState extends State<SortObjectsScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  int stars = 0;

  List<Map<String, dynamic>> objects = [

    {
      "name": "تفاحة 🍎",
      "correct": 1,
      "position": 0,
    },

    {
      "name": "موزة 🍌",
      "correct": 2,
      "position": 1,
    },

    {
      "name": "برتقالة 🍊",
      "correct": 3,
      "position": 2,
    },

  ];


  void playSound(String fileName) {

    audioPlayer.play(
      AssetSource('sounds/$fileName'),
    );

  }
  Future<void> checkOrder() async {

  bool correct = true;

  for (var item in objects) {

    if (item["position"] != item["correct"] - 1) {

      correct = false;

    }

  }


  if (correct) {

    playSound("correct.mp3");


    setState(() {

      stars++;

    });


    // حفظ تقدم لعبة ترتيب الأشياء
    await ProgressManager.saveCompletedGame(
      "sort_objects",
    );


    // زيادة عدد مرات الفوز
    await ProgressManager.addWinCount();


    // حفظ آخر لعبة
    await ProgressManager.saveLastPlayed(
      "ترتيب الأشياء",
    );


    // حفظ النجوم
    await ProgressManager.addStars(1);


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => WinScreen(
          stars: stars,
          nextGame: const SortObjectsScreen(),
          gamesPage: const GamesScreen(),
        ),
      ),
    );


  } else {


    playSound("wrong.mp3");


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "رتب الأشياء بشكل صحيح ⭐",
        ),

      ),

    );

  }

}

  void moveObject(int oldIndex, int newIndex) {

    setState(() {

      if (newIndex > oldIndex) {

        newIndex -= 1;

      }


      final item = objects.removeAt(oldIndex);

      objects.insert(newIndex, item);


      for (int i = 0; i < objects.length; i++) {

        objects[i]["position"] = i;

      }

    });

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

          "ترتيب الأشياء ⭐",

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

              "رتب الفواكه حسب الرقم",

              style: TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),


            const SizedBox(height: 30),


            Expanded(

              child: ReorderableListView(

                onReorder: moveObject,


                children: [

                  for (int i = 0; i < objects.length; i++)

                    Card(

                      key: ValueKey(objects[i]["name"]),

                      child: ListTile(

                        leading: const Icon(

                          Icons.drag_handle,

                          color: Colors.blue,

                        ),

                        title: Text(

                          objects[i]["name"],

                          textAlign: TextAlign.center,

                          style: const TextStyle(

                            fontSize: 30,

                            fontWeight: FontWeight.bold,

                          ),

                        ),

                      ),

                    ),

                ],

              ),

            ),


            const SizedBox(height: 20),


            ElevatedButton(

              onPressed: checkOrder,


              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.green,

                padding: const EdgeInsets.symmetric(

                  horizontal: 50,

                  vertical: 15,

                ),

                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(20),

                ),

              ),


              child: const Text(

                "تحقق ✅",

                style: TextStyle(

                  fontSize: 25,

                  color: Colors.white,

                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}