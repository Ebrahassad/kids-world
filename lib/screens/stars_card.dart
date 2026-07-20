import 'dart:math';
import 'package:flutter/material.dart';

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
      duration: const Duration(seconds: 2),
    )..repeat(
      reverse: true,
    );

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

      padding: const EdgeInsets.all(20),

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


          AnimatedBuilder(

            animation: controller,

            builder: (context, child) {


              double scale =
                  1 +
                  (controller.value * 0.08);


              double rotate =
                  sin(controller.value * pi)
                  * 0.08;


              return Transform.rotate(

                angle: rotate,

                child: Transform.scale(

                  scale: scale,

                  child: child,

                ),

              );

            },


            child: Container(

              width: 80,

              height: 80,


              decoration: BoxDecoration(

                shape:
                    BoxShape.circle,

                gradient:
                    const LinearGradient(

                  colors: [

                    Colors.yellow,

                    Colors.orange,

                  ],

                ),


                boxShadow: const [

                  BoxShadow(

                    color:
                        Colors.amber,

                    blurRadius:
                        20,

                    spreadRadius:
                        3,

                  ),

                ],

              ),


              child: const Center(

                child: Text(

                  "⭐😊",

                  style:
                      TextStyle(

                    fontSize: 45,

                  ),

                ),

              ),

            ),

          ),



          const SizedBox(width: 18),



          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,


              children: [


                const Text(

                  "مكافأتك 🎁",

                  style:
                      TextStyle(

                    fontSize: 18,

                    color:
                        Colors.grey,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),



                Text(

                  "${widget.totalStars} نجمة ⭐",

                  style:
                      const TextStyle(

                    fontSize: 30,

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

                    fontSize: 14,

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