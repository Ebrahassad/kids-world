import 'package:flutter/material.dart';
lib/screens/memory_screen.dart

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "اختيار المرحلة ⭐",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),


      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),


        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Text(
                "اختر اللعبة 🎮",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(height: 40),


              SizedBox(

                width: 250,
                height: 70,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),

                  ),


                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                        const MemoryGameScreen(),

                      ),

                    );

                  },


                  child: const Text(

                    "لعبة الذاكرة 🧠",

                    style: TextStyle(

                      fontSize: 25,

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

              ),


              const SizedBox(height: 25),


              levelButton(
                "المستوى 1 ⭐",
                Colors.orange,
              ),


              const SizedBox(height: 15),


              levelButton(
                "المستوى 2 ⭐⭐",
                Colors.purple,
              ),


              const SizedBox(height: 15),


              levelButton(
                "المستوى 3 ⭐⭐⭐",
                Colors.red,
              ),

            ],

          ),

        ),

      ),

    );

  }


  Widget levelButton(String text, Color color) {

    return SizedBox(

      width: 250,

      height: 60,

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

          backgroundColor: color,

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(30),

          ),

        ),


        onPressed: () {},


        child: Text(

          text,

          style: const TextStyle(

            fontSize: 22,

            color: Colors.white,

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

    );

  }

}