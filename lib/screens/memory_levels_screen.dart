import 'package:flutter/material.dart';

import 'memory_screen.dart';
import 'progress_manager.dart';


class MemoryLevelsScreen extends StatefulWidget {

  const MemoryLevelsScreen({super.key});

  @override
  State<MemoryLevelsScreen> createState() =>
      _MemoryLevelsScreenState();

}


class _MemoryLevelsScreenState
    extends State<MemoryLevelsScreen> {


  int unlockedLevel = 1;


  @override
  void initState() {

    super.initState();

    loadProgress();

  }



  Future<void> loadProgress() async {

    final level =
        await ProgressManager.getUnlockedLevel(
      "memory_game",
    );


    if (mounted) {

      setState(() {

        unlockedLevel =
            level < 1 ? 1 : level;

      });

    }

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
          Colors.lightBlue.shade50,



      appBar: AppBar(


        backgroundColor:
            Colors.blue,


        centerTitle: true,


        title: const Text(

          "مراحل لعبة الذاكرة 🧠",

          style: TextStyle(

            color: Colors.white,

            fontWeight:
                FontWeight.bold,

          ),

        ),

      ),




      body: Padding(


        padding:
            const EdgeInsets.all(16),



        child: GridView.builder(


          itemCount: 10,



          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(


            crossAxisCount: 2,


            crossAxisSpacing: 15,


            mainAxisSpacing: 15,


            childAspectRatio: 1.2,


          ),




          itemBuilder: (context,index){



            final level =
                index + 1;



            final unlocked =
                level <= unlockedLevel;



            return ElevatedButton(


              style:
                  ElevatedButton.styleFrom(


                backgroundColor:

                    unlocked
                        ? Colors.white
                        : Colors.grey.shade300,



                foregroundColor:

                    unlocked
                        ? Colors.blue
                        : Colors.grey,



                elevation:

                    unlocked ? 8 : 1,



                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(20),

                ),

              ),




              onPressed: unlocked

                  ? () async {


                      await Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>

                              MemoryGameScreen(

                            level: level,

                          ),

                        ),

                      );


                      // تحديث المستويات بعد الرجوع

                    await loadProgress();

                    }

                  : null,




              child: Column(


                mainAxisAlignment:
                    MainAxisAlignment.center,



                children: [



                  Text(

                    unlocked
                        ? "🧠"
                        : "🔒",

                    style:
                        const TextStyle(

                      fontSize: 45,

                    ),

                  ),




                  const SizedBox(height: 10),




                  Text(

                    "المستوى $level",

                    style:
                        const TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),




                  if (unlocked)

                    const Text(

                      "ابدأ اللعب ⭐",

                      style:
                          TextStyle(

                        color: Colors.green,

                        fontWeight:
                            FontWeight.bold,

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