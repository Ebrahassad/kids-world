import 'dart:async';
import 'package:flutter/material.dart';
import '../star_voice_manager.dart';
import 'happy_star.dart';

class ExitScreen extends StatefulWidget {
  const ExitScreen({super.key});

  @override
  State<ExitScreen> createState() => _ExitScreenState();
}

class _ExitScreenState extends State<ExitScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;


  @override
  void initState() {
    super.initState();


    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);


    animation = Tween<double>(
      begin: 0.9,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );


    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        StarVoiceManager.goodbye();
      },
    );


    Timer(
      const Duration(seconds: 3),
      () {
        // إغلاق التطبيق
        Navigator.of(context).pop();
      },
    );
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.png",
            ),
            fit: BoxFit.cover,
          ),
        ),


        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              ScaleTransition(
                scale: animation,

                child: const HappyStar(
                  size: 150,
                  message: "إلى اللقاء يا بطل ⭐",
                ),
              ),


              const SizedBox(height: 30),


              const Text(
                "شكراً للعب معنا ❤️",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),


              const SizedBox(height: 30),


              const CircularProgressIndicator(
                color: Colors.green,
              ),

            ],
          ),
        ),
      ),
    );
  }
}