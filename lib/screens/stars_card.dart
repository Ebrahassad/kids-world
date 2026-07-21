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



class _StarsCardState
    extends State<StarsCard>
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


    return AnimatedBuilder(

      animation: controller,


      builder: (context, child) {


        final glow =
            sin(controller.value * pi) * 0.1 + 0.9;


        return Transform.scale(

          scale: glow,


          child: Container(


            width: 320,


            padding:
                const EdgeInsets.all(18),



            decoration: BoxDecoration(


              gradient:
                  const LinearGradient(

                colors: [

                  Color(0xfffff8dc),

                  Colors.white,

                ],

                begin:
                    Alignment.topLeft,

                end:
                    Alignment.bottomRight,

              ),



              borderRadius:
                  BorderRadius.circular(30),



              boxShadow: const [


                BoxShadow(

                  color:
                      Colors.black26,

                  blurRadius:
                      15,

                  offset:
                      Offset(0,8),

                ),


              ],


            ),



            child: Row(


              children: [



                Transform.rotate(

                  angle:
                      sin(controller.value * pi)
                      * 0.1,


                  child: HappyStar(

                    size:90,

                    message:
                        "أحسنت ⭐",

                  ),

                ),




                const SizedBox(width:15),




                Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,


                  children: [



                    const Text(

                      "رصيد النجوم 🎁",

                      style:

                          TextStyle(

                        fontSize:18,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Colors.grey,

                      ),

                    ),




                    Row(

                      children: [



                        Text(

                          "${widget.totalStars}",

                          style:
                              const TextStyle(

                            fontSize:38,

                            fontWeight:
                                FontWeight.w900,

                            color:
                                Colors.orange,

                          ),

                        ),



                        const SizedBox(width:5),



                        const Text(

                          "⭐",

                          style:
                              TextStyle(

                            fontSize:35,

                          ),

                        ),



                      ],

                    ),





                    const Text(

                      "اجمع المزيد وافتح الجوائز 🚀",

                      style:
                          TextStyle(

                        fontSize:13,

                        color:
                            Colors.green,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),


                  ],

                ),


              ],


            ),


          ),

        );


      },

    );


  }

}