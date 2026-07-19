import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _scaleController;
  late AnimationController _fadeController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;


  @override
  void initState() {
    super.initState();


    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);


    _scaleAnimation = Tween<double>(
      begin: 0.90,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );


    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();


    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );


    Timer(
      const Duration(seconds: 2),
      () {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );

      },
    );
  }


  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
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


        child: FadeTransition(

          opacity: _fadeAnimation,

          child: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [


                const SizedBox(height: 40),


                Stack(

                  alignment: Alignment.center,

                  children: [


                    const Positioned(
                      top: -20,
                      left: 20,
                      child: Text(
                        "⭐",
                        style: TextStyle(fontSize: 45),
                      ),
                    ),


                    const Positioned(
                      bottom: -10,
                      right: 15,
                      child: Text(
                        "⭐",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),


                    ScaleTransition(

                      scale: _scaleAnimation,

                      child: Container(

                        width: 180,
                        height: 180,


                        decoration: BoxDecoration(

                          color: Colors.white,

                          shape: BoxShape.circle,

                          boxShadow: const [

                            BoxShadow(
                              color: Colors.blueAccent,
                              blurRadius: 25,
                              spreadRadius: 5,
                            ),

                          ],

                        ),


                        child: ClipOval(

                          child: Image.asset(

                            "assets/icon/app_icon.png",

                            fit: BoxFit.cover,

                          ),

                        ),

                      ),

                    ),

                  ],

                ),


                const SizedBox(height: 25),


                const Text(

                  "Kids World",

                  style: TextStyle(

                    fontSize: 42,

                    fontWeight: FontWeight.bold,

                    color: Colors.blue,

                  ),

                ),


                const SizedBox(height: 8),


                const Text(

                  "عالم الأطفال ⭐",

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                    color: Colors.black87,

                  ),

                ),


                const SizedBox(height: 12),


                const Text(

                  "تعلم ⭐ العب ⭐ اجمع النجوم",

                  style: TextStyle(

                    fontSize: 20,

                    color: Colors.black54,

                    fontWeight: FontWeight.bold,

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

      ),

    );

  }
}