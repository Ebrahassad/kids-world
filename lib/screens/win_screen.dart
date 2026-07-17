import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';

import 'game_screen.dart';


class WinScreen extends StatefulWidget {

  final int stars;


  const WinScreen({
    super.key,
    required this.stars,
  });


  @override
  State<WinScreen> createState() => _WinScreenState();

}



class _WinScreenState extends State<WinScreen> {


  final AudioPlayer audioPlayer = AudioPlayer();


  late ConfettiController confettiController;



  @override
  void initState() {

    super.initState();


    confettiController = ConfettiController(

      duration: const Duration(seconds: 5),

    );


    playWinSound();


    confettiController.play();

  }



  Future<void> playWinSound() async {

    try {

      await audioPlayer.play(

        AssetSource(
          "sounds/win.mp3",
        ),

      );

    } catch(e) {

      debugPrint(
        "خطأ الصوت: $e",
      );

    }

  }




  @override
  void dispose() {

    audioPlayer.dispose();

    confettiController.dispose();

    super.dispose();

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: const Color(0xffB3E5FC),



      body: Stack(


        alignment: Alignment.center,


        children: [



          Align(

            alignment: Alignment.topCenter,


            child: ConfettiWidget(

              confettiController: confettiController,


              blastDirectionality:
                  BlastDirectionality.explosive,


              shouldLoop: false,


              numberOfParticles: 50,


            ),

          ),





          Center(


            child: SingleChildScrollView(


              child: Padding(


                padding:
                    const EdgeInsets.all(25),



                child: Column(


                  mainAxisAlignment:
                      MainAxisAlignment.center,


                  children: [




                    const Text(

                      "🎉🏆⭐",

                      style: TextStyle(

                        fontSize: 80,

                      ),

                    ),




                    const SizedBox(height: 20),





                    const Text(

                      "مبروك! 🎊",

                      style: TextStyle(

                        fontSize: 42,

                        fontWeight:
                            FontWeight.bold,

                        color: Colors.green,

                      ),

                    ),





                    const SizedBox(height: 20),




                    const Text(

                      "لقد أكملت جميع الأسئلة بنجاح",

                      textAlign:
                          TextAlign.center,


                      style: TextStyle(

                        fontSize: 23,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),





                    const SizedBox(height: 25),





                    Container(

                      padding:
                          const EdgeInsets.all(15),


                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                      ),


                      child: Text(

                        "جمعت ⭐ ${widget.stars} نجوم",

                        style: const TextStyle(

                          fontSize: 32,

                          fontWeight:
                              FontWeight.bold,

                          color: Colors.orange,

                        ),

                      ),

                    ),





                    const SizedBox(height: 40),





                    SizedBox(

                      width: 250,

                      height: 60,


                      child: ElevatedButton.icon(


                        icon: const Icon(

                          Icons.refresh,

                          color: Colors.white,

                          size: 30,

                        ),



                        style:
                            ElevatedButton.styleFrom(


                          backgroundColor:
                              Colors.green,


                          shape:
                              RoundedRectangleBorder(


                            borderRadius:
                                BorderRadius.circular(25),


                          ),


                        ),




                        onPressed: () {


                          Navigator.pushReplacement(

                            context,


                            MaterialPageRoute(

                              builder: (_) =>
                                  const GameScreen(),

                            ),


                          );


                        },




                        label: const Text(

                          "إعادة اللعب",

                          style: TextStyle(

                            fontSize: 23,

                            color: Colors.white,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),

                      ),

                    ),






                    const SizedBox(height: 15),






                    TextButton(


                      onPressed: () {


                        Navigator.popUntil(

                          context,

                          (route) =>
                              route.isFirst,

                        );


                      },



                      child: const Text(

                        "العودة للرئيسية 🏠",

                        style: TextStyle(

                          fontSize: 21,

                          color: Colors.blue,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ),



                  ],

                ),

              ),

            ),

          ),


        ],

      ),

    );


  }


}