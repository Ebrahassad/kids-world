import 'package:flutter/material.dart';

import '../progress_manager.dart';
import 'memory_screen.dart';


class LevelsScreen extends StatefulWidget {

  const LevelsScreen({
    super.key,
  });


  @override
  State<LevelsScreen> createState() =>
      _LevelsScreenState();

}



class _LevelsScreenState extends State<LevelsScreen> {


  int unlockedLevel = 1;

  int stars = 0;



  @override
  void initState() {

    super.initState();

    loadData();

  }



  Future<void> loadData() async {

    final level =
        await ProgressManager.getUnlockedLevel(
          "memory_game",
        );


    final totalStars =
        await ProgressManager.getTotalStars();



    setState(() {

      unlockedLevel = level;

      stars = totalStars;

    });

  }





  void openLevel(int level) {


    if(level > unlockedLevel) {


      showDialog(

        context: context,

        builder: (context) {


          return AlertDialog(

            title: const Text(
              "🔒 المستوى مغلق",
            ),


            content: const Text(
              "أكمل المستويات السابقة أو افتحه بالنجوم ⭐",
            ),


            actions: [


              TextButton(

                onPressed: () {

                  Navigator.pop(context);

                },

                child: const Text(
                  "حسناً",
                ),

              ),


            ],

          );


        },

      );


      return;

    }



    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => MemoryGameScreen(
          level: level,
        ),

      ),

    );


  }





  Widget levelButton(

    int level,

    String text,

    Color color,

  ) {


    final locked =
        level > unlockedLevel;



    return SizedBox(

      width: 280,

      height: 65,


      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

          backgroundColor:
              locked ? Colors.grey : color,


          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(30),

          ),

        ),



        onPressed: () {

          openLevel(level);

        },



        child: Row(

          mainAxisAlignment:
              MainAxisAlignment.center,


          children: [


            Text(

              text,

              style: const TextStyle(

                fontSize: 22,

                color: Colors.white,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(width: 10),



            Icon(

              locked
                  ? Icons.lock
                  : Icons.play_circle_fill,


              color: Colors.white,

            ),


          ],

        ),


      ),

    );

  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(

          "مستويات لعبة الذاكرة 🧠",

          style: TextStyle(

            color: Colors.white,

            fontWeight:
                FontWeight.bold,

          ),

        ),

        centerTitle: true,

        backgroundColor: Colors.blue,

      ),





      body: Container(

        width: double.infinity,


        decoration: const BoxDecoration(


          gradient: LinearGradient(

            colors: [

              Colors.lightBlueAccent,

              Colors.white,

            ],


            begin:
                Alignment.topCenter,


            end:
                Alignment.bottomCenter,

          ),


        ),



        child: Column(


          mainAxisAlignment:
              MainAxisAlignment.center,


          children: [



            Text(

              "⭐ رصيدك: $stars",

              style: const TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(height: 20),




            const Text(

              "اختر المستوى ⭐",

              style: TextStyle(

                fontSize: 32,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(height: 40),



            levelButton(

              1,

              "المستوى الأول ⭐",

              Colors.green,

            ),



            const SizedBox(height: 20),



            levelButton(

              2,

              "المستوى الثاني ⭐⭐",

              Colors.orange,

            ),



            const SizedBox(height: 20),



            levelButton(

              3,

              "المستوى الثالث ⭐⭐⭐",

              Colors.red,

            ),


          ],


        ),


      ),


    );


  }


}