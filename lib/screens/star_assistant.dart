import 'package:flutter/material.dart';
import '../star_voice_manager.dart';
import 'happy_star.dart';


class StarAssistant extends StatelessWidget {

  const StarAssistant({
    super.key,
  });


  @override
  Widget build(BuildContext context) {


    return ValueListenableBuilder<bool>(

      valueListenable:
          StarVoiceManager.talkingNotifier,


      builder: (context, talking, child) {


        return SafeArea(

          child: Align(

            alignment:
                Alignment.topRight,


            child: Padding(

              padding:
                  const EdgeInsets.only(

                    top: 12,

                    right: 12,

                  ),


              child: Column(

                mainAxisSize:
                    MainAxisSize.min,


                crossAxisAlignment:
                    CrossAxisAlignment.end,


                children: [


                  if (talking)

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                            horizontal: 12,

                            vertical: 8,

                          ),


                      margin:
                          const EdgeInsets.only(
                            bottom: 5,
                          ),


                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),


                        boxShadow: const [

                          BoxShadow(

                            color:
                                Colors.black26,

                            blurRadius:
                                5,

                          ),

                        ],

                      ),


                      child:
                          const Text(

                        "أنا معك ⭐",

                        style:
                            TextStyle(

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ),



                  AnimatedScale(

                    scale:
                        talking ? 1.25 : 1.0,


                    duration:
                        const Duration(
                          milliseconds: 350,
                        ),


                    child:

                        HappyStar(

                          size:
                              talking ? 95 : 65,

                          idle:
                              !talking,

                          message:
                              "",

                        ),

                  ),


                ],

              ),

            ),

          ),

        );


      },

    );

  }

}