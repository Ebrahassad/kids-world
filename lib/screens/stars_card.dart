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

          AnimatedBuilder(

            animation: controller,

            builder:
                (context, child) {


              final double jump =

                  sin(controller.value * pi)

                      * 8;


              return Transform.translate(

                offset:
                    Offset(0, -jump),


                child:
                    Transform.rotate(

                  angle:

                      sin(controller.value * pi)

                          * 0.12,


                  child: child,

                ),

              );

            },


            child: Stack(

              alignment:
                  Alignment.center,


              children: [


                // ✨ الوهج

                Container(

                  width: 95,

                  height: 95,


                  decoration:
                      BoxDecoration(

                    shape:
                        BoxShape.circle,


                    boxShadow: [

                      BoxShadow(

                        color:

                            Colors.amber

                                .withOpacity(0.6),


                        blurRadius:
                            25,


                        spreadRadius:
                            5,

                      ),

                    ],

                  ),

                ),



                // ⭐ جسم النجمة

                Container(

                  width: 80,

                  height: 80,


                  decoration:
                      BoxDecoration(


                    shape:
                        BoxShape.circle,


                    gradient:
                        const LinearGradient(

                      colors: [

                        Color(0xfffff176),

                        Color(0xffff9800),

                      ],

                      begin:
                          Alignment.topLeft,


                      end:
                          Alignment.bottomRight,

                    ),



                    border:
                        Border.all(

                      color:
                          Colors.white,

                      width:
                          3,

                    ),

                  ),



                  child:
                      const Center(

                    child:
                        Text(

                      "⭐",

                      style:
                          TextStyle(

                        fontSize:
                            55,

                      ),

                    ),

                  ),

                ),



                // 😊 الوجه

                const Positioned(

                  bottom:
                      18,


                  child:
                      Text(

                    "😊",

                    style:
                        TextStyle(

                      fontSize:
                          22,

                    ),

                  ),

                ),


              ],

            ),

          ),



          const SizedBox(

            width: 18,

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