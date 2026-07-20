import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../star_voice_manager.dart';
import 'star_painter.dart';


class HappyStar extends StatefulWidget {

  final double size;

  final String message;


  const HappyStar({

    super.key,

    this.size = 90,

    this.message = "أحسنت يا بطل! ⭐",

  });


  @override
  State<HappyStar> createState() =>
      _HappyStarState();

}



class _HappyStarState extends State<HappyStar>
    with SingleTickerProviderStateMixin {


  bool blink = false;
bool talking = false;
bool mouthOpen = false;
double starRotation = 0;


Timer? blinkTimer;
Timer? mouthTimer;

late AnimationController glowController;
late Animation<double> glowAnimation;

  @override
void initState() {
  super.initState();
glowController = AnimationController(
  vsync: this,
  duration: const Duration(
    milliseconds: 900,
  ),
);

glowAnimation = Tween<double>(
  begin: 1.0,
  end: 1.15,
).animate(
  CurvedAnimation(
    parent: glowController,
    curve: Curves.easeInOut,
  ),
);

glowController.repeat(
  reverse: true,
);
  startBlink();


  talking = StarVoiceManager.isTalking;

  StarVoiceManager.talkingNotifier.addListener(
    _talkListener,
  );
}



  void startBlink() {
  blinkTimer = Timer.periodic(
    const Duration(seconds: 3),
    (timer) {
      if (!mounted) return;

      setState(() {
        blink = true;
      });

      Future.delayed(
        const Duration(milliseconds: 180),
        () {
          if (!mounted) return;

          setState(() {
            blink = false;
          });
        },
      );
    },
  );
}


void _talkListener() {
  if (!mounted) return;

  final bool isTalking =
      StarVoiceManager.talkingNotifier.value;

  if (isTalking) {
    mouthTimer?.cancel();

    mouthTimer = Timer.periodic(
      const Duration(milliseconds: 180),
      (_) {
        if (!mounted) return;

        setState(() {
  mouthOpen = !mouthOpen;

  starRotation =
      starRotation == 0 ? 0.06 : 0;
});
      },
    );
  } else {
    mouthTimer?.cancel();

    setState(() {
      mouthOpen = false;
    });
  }

  setState(() {
    talking = isTalking;
  });
}
@override
void dispose() {
  StarVoiceManager.talkingNotifier.removeListener(
    _talkListener,
  );

blinkTimer?.cancel();
mouthTimer?.cancel(); 

glowController.dispose();

super.dispose();
}

  @override
  Widget build(BuildContext context) {

    return Row(

      mainAxisSize:
          MainAxisSize.min,


      children: [


        Transform.rotate(
  angle: starRotation,
  child: AnimatedBuilder(
  animation: glowAnimation,
  builder: (context, child) {
    return CustomPaint(
      size: Size(
        widget.size,
        widget.size,
      ),
      painter: StarPainter(
        blink: blink,
        talking: mouthOpen,
        glowScale: glowAnimation.value,
      ),
    );
  },
),
),

        const SizedBox(

          width: 10,

        ),



        Container(

          padding:
              const EdgeInsets.all(12),


          decoration:
              BoxDecoration(

            color:
                Colors.white,


            borderRadius:
                BorderRadius.circular(18),


            boxShadow: const [

              BoxShadow(

                color:
                    Colors.black12,

                blurRadius:
                    8,

                offset:
                    Offset(0, 3),

              ),

            ],

          ),



          child: Text(

            widget.message,


            style:
                const TextStyle(

              fontSize:
                  16,

              fontWeight:
                  FontWeight.bold,

              color:
                  Colors.black87,

            ),

          ),

        ),


      ],

    );

  }

}



