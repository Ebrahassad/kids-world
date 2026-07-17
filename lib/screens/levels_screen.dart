import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'choose_image_screen.dart';
import 'match_image_screen.dart';
import 'colors_screen.dart';
import 'numbers_screen.dart';
import 'letters_screen.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  final List<String> levels = const [
    "تعرف على الصور",
    "اختيار الصورة الصحيحة",
    "مطابقة الصور",
    "تعلم الألوان",
    "تعلم الأرقام",
    "تعلم الحروف",
    "لعبة الذاكرة",
    "ترتيب الأشياء",
    "رتّب الصورة",
    "تجميع الصورة الصعبة 🧩",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.lightBlue.shade50,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,

        title: const Text(
          "اختيار المرحلة ⭐",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),


      body: Padding(

        padding: const EdgeInsets.all(20),

        child: GridView.builder(

          itemCount: levels.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,

            crossAxisSpacing: 15,

            mainAxisSpacing: 15,

          ),


          itemBuilder: (context, index) {


            return ElevatedButton(

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.green,

                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(25),

                ),

              ),


              onPressed: () {


                if (index == 0) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GameScreen(),
                    ),
                  );


                } else if (index == 1) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChooseImageScreen(),
                    ),
                  );


                } else if (index == 2) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MatchImageScreen(),
                    ),
                  );


                } else if (index == 3) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ColorsScreen(),
                    ),
                  );


                } else if (index == 4) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NumbersScreen(),
                    ),
                  );


                } else if (index == 5) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LettersScreen(),
                    ),
                  );


                } else {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(

                      content: Text(
                        "هذه المرحلة قيد التطوير 🚀",
                      ),

                    ),

                  );

                }


              },


              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,


                children: [


                  const Icon(

                    Icons.star,

                    color: Colors.yellow,

                    size: 45,

                  ),


                  const SizedBox(height: 10),


                  Text(

                    levels[index],

                    textAlign: TextAlign.center,


                    style: const TextStyle(

                      fontSize: 20,

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                    ),

                  ),


                ],

              ),

            );

          },

        ),

      ),

    );

  }

}