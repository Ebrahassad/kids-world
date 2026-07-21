import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';

import '../progress_manager.dart';
import '../star_voice_manager.dart';
import '../widgets/kids_scaffold.dart';

import 'win_button_3d.dart';
import 'stars_card.dart';



class WinScreen extends StatefulWidget {


  final int stars;

  final int gameId;

  final Widget nextGame;

  final Widget gamesPage;


  final bool hasLevels;


  final int currentLevel;


  final int maxLevels;


  final Widget? nextLevelPage;



  const WinScreen({

    super.key,

    required this.stars,

    required this.gameId,

    required this.nextGame,

    required this.gamesPage,

    this.hasLevels = false,

    this.currentLevel = 1,

    this.maxLevels = 1,

    this.nextLevelPage,

  });



  @override
  State<WinScreen> createState() =>
      _WinScreenState();

}





class _WinScreenState extends State<WinScreen> {


  final AudioPlayer audioPlayer =
      AudioPlayer();



  late ConfettiController confettiController;





  @override
  void initState() {

    super.initState();



    confettiController =
        ConfettiController(

      duration:
          const Duration(seconds: 5),

    );



    confettiController.play();



    saveProgress();



    playWinSound();


  }






  Future<void> saveProgress() async {


    // حفظ النجوم
    await ProgressManager.saveStars(

      "memory_game",

      widget.stars,

    );



    // فتح اللعبة التالية
    await ProgressManager.unlockNextGame(

      widget.gameId,

    );



    // حفظ تقدم المستوى
    if(widget.hasLevels){


      await ProgressManager.saveCompletedLevel(

        "memory_game",

        widget.currentLevel,

      );



      if(widget.currentLevel < widget.maxLevels){


        await ProgressManager.saveUnlockedLevel(

          "memory_game",

          widget.currentLevel + 1,

        );


      }


    }


  }







  Future<int> getTotalStars() async {


    return await ProgressManager
        .getTotalStars();


  }






  Future<void> playWinSound() async {


    try {


      await audioPlayer.play(

        AssetSource(
          "sounds/win.mp3",
        ),

      );



      await audioPlayer
          .onPlayerComplete
          .first;



      await Future.delayed(

        const Duration(
          milliseconds: 500,
        ),

      );



      await StarVoiceManager.win();



    } catch(e){


      debugPrint(
        "Win Sound Error: $e",
      );


    }


  }






  @override
  void dispose(){

    audioPlayer.dispose();

    confettiController.dispose();

    super.dispose();

  }








  @override
  Widget build(BuildContext context){



    final isLastLevel =
        widget.currentLevel >= widget.maxLevels;




    return KidsScaffold(


      backgroundColor:
          const Color(0xffB3E5FC),



      child: Stack(


        alignment:
            Alignment.center,



        children: [



          Align(

            alignment:
                Alignment.topCenter,


            child: ConfettiWidget(

              confettiController:
                  confettiController,


              blastDirectionality:
                  BlastDirectionality.explosive,


              numberOfParticles:
                  50,


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

                        color:
                            Colors.green,

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




                    FutureBuilder<int>(


                      future:
                          getTotalStars(),



                      builder:(context,snapshot){


                        return StarsCard(

                          totalStars:
                              snapshot.data ??
                              widget.stars,

                        );


                      },

                    ),





                    const SizedBox(height:20),





                    Container(


                      padding:
                          const EdgeInsets.all(15),



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
                                8,

                          ),

                        ],


                      ),



                      child: Text(

                        "⭐ ${StarVoiceManager.winMessage()}",


                        textAlign:
                            TextAlign.center,



                        style:
                            const TextStyle(

                          fontSize:18,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ),






                    const SizedBox(height:40),






                    if(widget.hasLevels)


                      WinButton3D(


                        text:

                        isLastLevel

                            ? "العودة للمراحل 📋"

                            : "المستوى التالي ➡",



                        icon:

                        isLastLevel

                            ? Icons.list

                            : Icons.arrow_forward,



                        color:
                            Colors.orange,



                        onPressed:(){



                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(

                              builder:(_){


                                if(isLastLevel ||
                                   widget.nextLevelPage == null){

                                  return widget.gamesPage;

                                }


                                return widget.nextLevelPage!;


                              },

                            ),

                          );


                        },

                      ),






                    const SizedBox(height:15),






                    WinButton3D(


                      text:
                          "إعادة اللعب 🔄",



                      icon:
                          Icons.refresh,



                      color:
                          Colors.green,



                      onPressed:(){


                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder:(_)=>
                                widget.nextGame,

                          ),

                        );


                      },


                    ),






                    const SizedBox(height:15),





                    WinButton3D(


                      text:

                      widget.hasLevels

                          ? "المراحل 📋"

                          : "صفحة الألعاب 🎮",



                      icon:

                      widget.hasLevels

                          ? Icons.list

                          : Icons.games,



                      color:
                          Colors.blue,



                      onPressed:(){



                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder:(_)=>
                                widget.gamesPage,

                          ),

                        );


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