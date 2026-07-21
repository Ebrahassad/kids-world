import 'package:flutter/material.dart';

import '../star_voice_manager.dart';
import '../progress_manager.dart';
import '../reward_ad_manager.dart';
import 'happy_star.dart';


class StarAssistant extends StatefulWidget {

  final String gameName;
  final int currentLevel;

  const StarAssistant({

    super.key,

    this.gameName = "memory_game",

    this.currentLevel = 1,

  });


  @override
  State<StarAssistant> createState() => _StarAssistantState();

}


class _StarAssistantState extends State<StarAssistant>
    with SingleTickerProviderStateMixin {


  bool menuVisible = false;

  int stars = 0;


  late AnimationController animationController;


  late Animation<double> scaleAnimation;



  @override
  void initState() {

    super.initState();


    animationController = AnimationController(

      vsync: this,

      duration: const Duration(
        milliseconds: 350,
      ),

    );


    scaleAnimation = CurvedAnimation(

      parent: animationController,

      curve: Curves.elasticOut,

    );


  }



  @override
  void dispose(){

    animationController.dispose();

    super.dispose();

  }




  Future<void> openStarMenu() async {


    stars =
        await ProgressManager.getTotalStars();


    setState(() {

      menuVisible = true;

    });


    animationController.forward(
      from: 0,
    );


  }



  void closeStarMenu(){


    animationController.reverse();


    Future.delayed(

      const Duration(
        milliseconds:200,
      ),

      (){

        if(mounted){

          setState(() {

            menuVisible = false;

          });

        }

      },

    );


  }



  Widget starTitle(String text){

    return Text(

      text,

      textAlign: TextAlign.center,


      style: TextStyle(

        fontSize: 22,

        fontWeight: FontWeight.w900,

        color: Colors.orange.shade700,


        shadows: const [

          Shadow(

            color: Colors.white,

            offset: Offset(0,-2),

            blurRadius: 2,

          ),


          Shadow(

            color: Colors.brown,

            offset: Offset(0,3),

            blurRadius: 2,

          ),

        ],

      ),

    );

  }

  Widget starMenuCard({

    required IconData icon,

    required String title,

    required Color color,

    required VoidCallback onTap,

  }){


    return InkWell(

      borderRadius: BorderRadius.circular(20),

      onTap: onTap,


      child: Container(

        margin: const EdgeInsets.symmetric(
          vertical: 6,
        ),


        padding: const EdgeInsets.all(12),


        decoration: BoxDecoration(

          color: color.withOpacity(0.15),

          borderRadius: BorderRadius.circular(20),


          border: Border.all(

            color: color.withOpacity(0.5),

            width: 2,

          ),


          boxShadow: [

            BoxShadow(

              color: color.withOpacity(0.25),

              blurRadius: 8,

              offset: const Offset(0,4),

            ),

          ],

        ),



        child: Row(

          children: [


            Container(

              padding: const EdgeInsets.all(8),


              decoration: BoxDecoration(

                color: color,

                shape: BoxShape.circle,

              ),


              child: Icon(

                icon,

                color: Colors.white,

                size: 28,

              ),

            ),



            const SizedBox(width:12),



            Expanded(

              child: Text(

                title,


                style: TextStyle(

                  fontSize: 18,

                  fontWeight: FontWeight.w900,

                  color: color,

                  shadows: const [

                    Shadow(

                      color: Colors.white,

                      offset: Offset(0,-1),

                      blurRadius: 1,

                    ),

                  ],

                ),

              ),

            ),



          ],

        ),

      ),

    );

  }






  Widget floatingStarMenu(){


    if(!menuVisible){

      return const SizedBox();

    }



    return Positioned(

      top: 85,

      right: 15,


      child: ScaleTransition(

        scale: scaleAnimation,


        child: Container(

          width: 260,


          padding: const EdgeInsets.all(16),


          decoration: BoxDecoration(


            color: Colors.white,


            borderRadius: BorderRadius.circular(28),


            boxShadow: [

              BoxShadow(

                color: Colors.black.withOpacity(0.25),

                blurRadius: 15,

                offset: const Offset(0,8),

              ),

            ],

          ),



          child: Column(

            mainAxisSize: MainAxisSize.min,


            children: [



              starTitle(
                "⭐ أنا نجمتك",
              ),



              const SizedBox(height:8),



              Text(

                "ماذا تريد أن أفعل؟",

                style: TextStyle(

                  fontSize: 16,

                  fontWeight: FontWeight.bold,

                  color: Colors.grey.shade700,

                ),

              ),



              const SizedBox(height:12),



              Container(

                padding: const EdgeInsets.all(8),

                decoration: BoxDecoration(

                  color: Colors.amber.shade100,

                  borderRadius: BorderRadius.circular(15),

                ),

                child: Text(

                  "⭐ رصيدك: $stars",

                  style: const TextStyle(

                    fontSize:18,

                    fontWeight: FontWeight.bold,

                  ),

                ),

              ),



              const SizedBox(height:10),



              starMenuCard(

                icon: Icons.lightbulb,

                title:"تلميح 💡",

                color:Colors.orange,

                onTap: (){

                  closeStarMenu();

                  StarVoiceManager.hint();

                },

              ),



              starMenuCard(

                icon:Icons.card_giftcard,

                title:"شاهد إعلان واحصل على 50 ⭐",

                color:Colors.purple,

                onTap: () async {

                  closeStarMenu();

                  final rewarded =
                      await RewardAdManager.showRewardAd();


                  if(rewarded){

                    await ProgressManager.addStars(50);

                  }

                },

              ),



              starMenuCard(

  icon: Icons.lock_open,

  title: "فتح المستوى التالي 🔓",

  color: Colors.green,

  onTap: () {

    closeStarMenu();

    unlockLevel();

  },

),


              TextButton(

                onPressed: closeStarMenu,

                child: const Text(

                  "إغلاق ✖",

                  style: TextStyle(

                    fontWeight: FontWeight.bold,

                  ),

                ),

              ),


            ],

          ),

        ),

      ),

    );

  }


 id="b4s7qj"
  @override
  Widget build(BuildContext context) {


    return ValueListenableBuilder<bool>(

      valueListenable:
          StarVoiceManager.talkingNotifier,


      builder: (context, talking, child) {


        return Stack(

          children: [


            floatingStarMenu(),



            SafeArea(

              child: Align(

                alignment: Alignment.topRight,


                child: Padding(

                  padding: const EdgeInsets.only(

                    top:12,

                    right:12,

                  ),


                  child: Column(

                    mainAxisSize:
                        MainAxisSize.min,


                    crossAxisAlignment:
                        CrossAxisAlignment.end,


                    children: [



                      if(talking)

                        Container(

                          padding:
                              const EdgeInsets.all(10),


                          decoration:
                              BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(20),

                            boxShadow: [

                              BoxShadow(

                                color:
                                    Colors.black.withOpacity(0.15),

                                blurRadius:8,

                              ),

                            ],

                          ),


                          child: const Text(

                            "أنا معك ⭐",

                            style: TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          ),

                        ),




                      GestureDetector(


                        onTap: () {

  if(menuVisible){

    closeStarMenu();

  }
  else{

    openStarMenu();

  }

},

                        child: AnimatedScale(


                          scale:
                              talking ? 1.25 : 1.0,


                          duration:
                              const Duration(

                            milliseconds:350,

                          ),



                          child: HappyStar(

                            size:
                                talking ? 95 : 75,

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

            ),


          ],

        );


      },

    );


  }



  Future<void> unlockLevel() async {


    const cost = 20;


    final paid =
        await ProgressManager.spendStars(cost);



    if(paid){


      await ProgressManager.saveUnlockedLevel(

        widget.gameName,

        widget.currentLevel + 1,

      );


      await StarVoiceManager.unlock();



      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(

            "تم فتح المستوى التالي 🔓⭐",

          ),

        ),

      );



    }

    else{


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(

            "تحتاج 20 نجمة ⭐",

          ),

        ),

      );


    }


  }