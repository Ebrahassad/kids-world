import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';


class WinScreen extends StatefulWidget {

  final int stars;

  final Widget nextGame;

  final Widget gamesPage;


  const WinScreen({

    super.key,

    required this.stars,

    required this.nextGame,

    required this.gamesPage,

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





  Widget actionButton({

    required String text,

    required IconData icon,

    required Color color,

    required VoidCallback onPressed,

  }) {


    return SizedBox(

      width: 270,

      height: 60,


      child: ElevatedButton.icon(


        onPressed: onPressed,


        icon: Icon(

          icon,

          color: Colors.white,

          size: 30,

        ),


        label: Text(

          text,

          style: const TextStyle(

            fontSize: 22,

            color: Colors.white,

            fontWeight: FontWeight.bold,

          ),

        ),



        style: ElevatedButton.styleFrom(

          backgroundColor: color,


          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(25),

          ),


        ),


      ),

    );

  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
          const Color(0xffB3E5FC),



      body: Stack(


        alignment: Alignment.center,


        children: [



          Align(

            alignment: Alignment.topCenter,


            child: ConfettiWidget(

              confettiController:
                  confettiController,


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





                    const SizedBox(height:20),




                    const Text(

                      "مبروك! 🎊",

                      style: TextStyle(

                        fontSize:42,

                        fontWeight:
                            FontWeight.bold,

                        color:Colors.green,

                      ),

                    ),





                    const SizedBox(height:20),




                    const Text(

                      "أكملت اللعبة بنجاح 👏",

                      textAlign:
                          TextAlign.center,


                      style: TextStyle(

                        fontSize:23,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),





                    const SizedBox(height:25),




                    Container(


                      padding:
                          const EdgeInsets.all(15),



                      decoration: BoxDecoration(


                        color:Colors.white,


                        borderRadius:
                            BorderRadius.circular(20),


                      ),



                      child: Text(


                        "جمعت ⭐ ${widget.stars} نجوم",



                        style: const TextStyle(


                          fontSize:32,


                          fontWeight:
                              FontWeight.bold,


                          color:Colors.orange,


                        ),


                      ),


                    ),





                    const SizedBox(height:40),





                    // زر إعادة اللعب

                    actionButton(

                      text:"إعادة اللعب 🔄",

                      icon:Icons.refresh,

                      color:Colors.green,

                      onPressed: () {


                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                widget.nextGame,

                          ),

                        );


                      },

                    ),




                    const SizedBox(height:15),





                    // زر صفحة الألعاب

                    actionButton(

                      text:"صفحة الألعاب 🎮",

                      icon:Icons.games,

                      color:Colors.blue,

                      onPressed: () {


                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                widget.gamesPage,

                          ),

                        );


                      },

                    ),




                    const SizedBox(height:15),





                    // زر إغلاق التطبيق

                    actionButton(

                      text:"إغلاق التطبيق 🚪",

                      icon:Icons.exit_to_app,

                      color:Colors.red,

                      onPressed: () {


                        SystemNavigator.pop();


                      },

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