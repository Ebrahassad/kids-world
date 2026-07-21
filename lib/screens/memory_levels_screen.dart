import 'package:flutter/material.dart';

import 'memory_screen.dart';
import '../progress_manager.dart';



class MemoryLevelsScreen extends StatefulWidget {

  const MemoryLevelsScreen({
    super.key,
  });


  @override
  State<MemoryLevelsScreen> createState() =>
      _MemoryLevelsScreenState();

}





class _MemoryLevelsScreenState
    extends State<MemoryLevelsScreen> {


  int unlockedLevel = 1;

  int totalStars = 0;



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


    final stars =
        await ProgressManager.getTotalStars();



    if(mounted){

      setState(() {

        unlockedLevel =
            level < 1 ? 1 : level;

        totalStars =
            stars;

      });

    }

  }





  Future<void> unlockLevel(
      int level
  ) async {


    const cost = 20;



    final success =
        await ProgressManager.spendStars(
          cost,
        );



    if(success){


      await ProgressManager.saveUnlockedLevel(

        "memory_game",

        level,

      );



      await loadProgress();



      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "تم فتح المستوى 🔓⭐",
          ),

        ),

      );



    }else{


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "تحتاج 20 نجمة ⭐",
          ),

        ),

      );


    }


  }







  Future<void> openLevel(
      int level
  ) async {


    final unlocked =
        level <= unlockedLevel;



    if(unlocked){


      await Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) =>
              MemoryGameScreen(

                level: level,

              ),

        ),

      );


      await loadProgress();



    }else{


      showDialog(

        context: context,

        builder: (context){


          return AlertDialog(


            title: const Text(
              "🔒 المستوى مغلق",
            ),


            content: const Text(

              "يمكنك فتحه باستخدام 20 نجمة ⭐",

            ),



            actions: [


              TextButton(

                onPressed: (){

                  Navigator.pop(context);

                },

                child: const Text(
                  "إلغاء",
                ),

              ),



              ElevatedButton(

                onPressed: (){

                  Navigator.pop(context);

                  unlockLevel(level);

                },


                child: const Text(
                  "فتح 🔓",
                ),

              ),


            ],


          );


        },

      );


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





      body: Column(


        children: [



          Container(

            margin:
                const EdgeInsets.all(15),


            padding:
                const EdgeInsets.all(12),


            decoration:
                BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(20),

              boxShadow: const [

                BoxShadow(

                  color: Colors.black12,

                  blurRadius: 5,

                ),

              ],

            ),



            child: Text(

              "⭐ رصيد النجوم: $totalStars",

              style: const TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

              ),

            ),


          ),





          Expanded(


            child: Padding(


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





                itemBuilder:
                    (context,index){



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



                      elevation:

                          unlocked ? 8 : 1,



                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(20),

                      ),


                    ),




                    onPressed: (){

                      openLevel(level);

                    },




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



                        const SizedBox(height:10),



                        Text(

                          "المستوى $level",

                          style:
                              const TextStyle(

                            fontSize:20,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),



                        Text(

                          unlocked

                              ? "ابدأ اللعب ⭐"

                              : "20 نجمة 🔓",


                          style:
                              TextStyle(

                            color:

                                unlocked

                                    ? Colors.green

                                    : Colors.red,

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


          ),


        ],


      ),


    );


  }


}