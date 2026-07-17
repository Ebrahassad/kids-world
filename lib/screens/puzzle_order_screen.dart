import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'win_screen.dart';

class PuzzleOrderScreen extends StatefulWidget {
  const PuzzleOrderScreen({super.key});

  @override
  State<PuzzleOrderScreen> createState() => _PuzzleOrderScreenState();
}

class _PuzzleOrderScreenState extends State<PuzzleOrderScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  int stars = 0;

  List<String> pieces = [
    "🐑",
    "🌳",
    "☀️",
    "🏠",
  ];

  List<String> correctOrder = [
    "☀️",
    "🌳",
    "🏠",
    "🐑",
  ];

  void playSound(String fileName) {
    audioPlayer.play(
      AssetSource('sounds/$fileName'),
    );
  }

  void checkPuzzle() {

    if (pieces.toString() == correctOrder.toString()) {

      playSound("correct.mp3");

      setState(() {
  stars++;
});

Future.delayed(
  const Duration(milliseconds: 500),
  () {

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const WinScreen(),
      ),
    );

  },
);
    } else {

      playSound("wrong.mp3");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "رتب الصورة بشكل صحيح ⭐",
          ),
        ),
      );

    }
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
          "رتّب الصورة ⭐",
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

              "اسحب القطع ورتب الصورة",

              style: TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),


            const SizedBox(height: 30),


            Expanded(

              child: ReorderableListView(

                onReorder: (oldIndex, newIndex) {

                  setState(() {

                    if (newIndex > oldIndex) {

                      newIndex--;

                    }

                    final item = pieces.removeAt(oldIndex);

                    pieces.insert(newIndex, item);

                  });

                },


                children: [

  for (int i = 0; i < pieces.length; i++)

    Card(

      key: ValueKey(i),

      child: ListTile(

        leading: const Icon(
          Icons.drag_handle,
          color: Colors.blue,
        ),

        title: Text(
          pieces[i],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 45,
          ),
        ),

      ),

    ),

],
              ),

            ),
            const SizedBox(height: 20),


            ElevatedButton(

              onPressed: checkPuzzle,


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