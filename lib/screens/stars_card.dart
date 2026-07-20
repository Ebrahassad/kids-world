import 'dart:math';
import 'package:flutter/material.dart';
import 'happy_star.dart';

class StarsCard extends StatefulWidget {

  final int totalStars;

  const StarsCard({
    super.key,
    required this.totalStars,
  });

  @override
  State<StarsCard> createState() =>
      _StarsCardState();
}


class _StarsCardState extends State<StarsCard>
    with SingleTickerProviderStateMixin {


  late AnimationController controller;


  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration:
          const Duration(seconds: 2),

    )..repeat();

  }



  @override
  void dispose() {

    controller.dispose();

    super.dispose();

  }



  @override
  Widget build(BuildContext context) {

    return Container(

      width: 310,

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(30),

        boxShadow: const [

          BoxShadow(

            color: Colors.black26,

            blurRadius: 15,

            offset:
                Offset(0, 8),

          ),

        ],

      ),



      child: Row(

        children: [


          // ⭐ النجمة الشخصية
// ⭐ النجمة الشخصية الجديدة

AnimatedBuilder(
  animation: controller,

  builder: (context, child) {

    final double jump =
        sin(controller.value * pi) * 8;

    return Transform.translate(

      offset: Offset(0, -jump),

      child: Transform.rotate(

        angle:
            sin(controller.value * pi) * 0.12,

        child: child,

      ),

    );

  },

  child: HappyStar(
  size: 90,
  message: "أحسنت يا بطل! ⭐",

  ),

),



          Expanded(

            child: Column(

              crossAxisAlignment:

                  CrossAxisAlignment.start,


              children: [


                const Text(

                  "مكافأتك 🎁",

                  style:
                      TextStyle(

                    fontSize:
                        18,

                    color:
                        Colors.grey,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),



                Text(

                  "${widget.totalStars} ⭐",

                  style:
                      const TextStyle(

                    fontSize:
                        34,

                    fontWeight:
                        FontWeight.w900,

                    color:
                        Colors.orange,

                  ),

                ),



                const Text(

                  "أحسنت! واصل اللعب 👏",

                  style:
                      TextStyle(

                    fontSize:
                        14,

                    color:
                        Colors.green,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),


              ],

            ),

          ),


        ],

      ),

    );

  }

}