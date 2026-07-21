import 'package:flutter/material.dart';
import '../star_voice_manager.dart';
import '../progress_manager.dart';
import 'happy_star.dart';




class StarAssistant extends StatelessWidget {

  const StarAssistant({
    super.key,
  });


  void openStarMenu(BuildContext context) async {

  final stars = await ProgressManager.getTotalStars();

  
    showModalBottomSheet(

      context: context,

      backgroundColor: Colors.transparent,

      builder: (context) {

        return Container(

          padding: const EdgeInsets.all(20),

          decoration: const BoxDecoration(

            color: Colors.white,

            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),

          ),


          child: Column(

            mainAxisSize: MainAxisSize.min,


            children: [


              const Text(

                "⭐ ماذا تريد أن تفعل؟",

                style: TextStyle(

                  fontSize: 24,

                  fontWeight: FontWeight.bold,

                ),

              ),


              const SizedBox(height: 20),



              ListTile(

                leading: const Icon(
                  Icons.lightbulb,
                  color: Colors.orange,
                ),

                title: const Text(
                  "تلميح 💡",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                onTap: () {

                  Navigator.pop(context);

                  StarVoiceManager.hint();

                },

              ),



              ListTile(

                leading: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),

                title: Text(
  "رصيد النجوم ⭐ $stars",
  style: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

                onTap: () {

                  Navigator.pop(context);

                  StarVoiceManager.stars();

                },

              ),



              ListTile(

                leading: const Icon(
                  Icons.lock_open,
                  color: Colors.green,
                ),

                title: const Text(
                  "فتح مرحلة 🔓",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                onTap: () {

                  Navigator.pop(context);

                  StarVoiceManager.unlock();

                },

              ),


            ],

          ),

        );

      },

    );

  }



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
                          const EdgeInsets.all(10),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

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



                  GestureDetector(

                    onTap: () async {

  await StarVoiceManager.chooseGame();

  openStarMenu(context);

},


                    child: AnimatedScale(

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