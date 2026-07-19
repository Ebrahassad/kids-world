import 'package:flutter/material.dart';

import '../games_screen.dart';

class GameCard extends StatelessWidget {
  final GameItem game;
  final bool unlocked;
  final int index;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.game,
    required this.unlocked,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder<double>(
      duration: Duration(
        milliseconds: 450 + (index * 80),
      ),

      curve: Curves.easeOutCubic,

      tween: Tween(
        begin: 0,
        end: 1,
      ),

      builder: (context, value, child) {

        return Opacity(
          opacity: value,

          child: Transform.translate(
            offset: Offset(
              0,
              (1 - value) * 40,
            ),

            child: Transform.scale(
              scale: 0.9 + (0.1 * value),

              child: child,
            ),
          ),
        );

      },

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(24),

          onTap: onTap,

          child: Ink(
            decoration: BoxDecoration(

              borderRadius:
                  BorderRadius.circular(24),

              border: Border.all(
                color:
                    Colors.white.withOpacity(0.18),
                width: 1.2,
              ),

              gradient: LinearGradient(

                begin:
                    Alignment.topLeft,

                end:
                    Alignment.bottomRight,

                colors: [

                  game.color,

                  game.color.withOpacity(0.75),

                ],
              ),

              boxShadow: [

                BoxShadow(
                  color:
                      game.color.withOpacity(0.35),

                  blurRadius:
                      20,

                  spreadRadius:
                      1,

                  offset:
                      const Offset(0, 10),
                ),

              ],
            ),

            child: ClipRRect(

              borderRadius:
                  BorderRadius.circular(24),

              child: Stack(

                children: [

                  Center(

                    child: Stack(

                      alignment:
                          Alignment.center,

                      children: [

                        Container(

                          width: 85,

                          height: 85,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            color:
                                Colors.white.withOpacity(0.15),

                          ),

                        ),

                        AnimatedOpacity(

                          duration:
                              const Duration(
                                milliseconds: 400,
                              ),

                          opacity:
                              unlocked ? 1 : 0.35,

                          child: Image.asset(

                            game.image,

                            width:
                                95,

                            height:
                                95,

                            fit:
                                BoxFit.contain,

                          ),

                        ),

                      ],

                    ),

                  ),


                  Positioned(

                    top: 10,

                    left: 10,

                    child: Container(

                      width: 34,

                      height: 34,

                      decoration:
                          BoxDecoration(

                        shape:
                            BoxShape.circle,

                        color:
                            Colors.white,

                        boxShadow: [

                          BoxShadow(

                            color:
                                Colors.black.withOpacity(0.15),

                            blurRadius:
                                8,

                            offset:
                                const Offset(0, 3),

                          ),

                        ],

                      ),

                      child: Center(

                        child: Text(

                          "${game.id}",

                          style:
                              TextStyle(

                            color:
                                game.color,

                            fontWeight:
                                FontWeight.bold,

                            fontSize:
                                15,

                          ),

                        ),

                      ),

                    ),

                  ),


                  Positioned(

                    bottom: 18,

                    left: 10,

                    right: 10,

                    child: Text(

                      game.title,

                      textAlign:
                          TextAlign.center,

                      maxLines:
                          2,

                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontSize:
                            18,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),

                  ),


                  if (!unlocked)

                    Positioned.fill(

                      child: Container(

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.black54,

                          borderRadius:
                              BorderRadius.circular(24),

                        ),

                        child: Center(

                          child: Container(

                            padding:
                                const EdgeInsets.all(14),

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white.withOpacity(0.15),

                              shape:
                                  BoxShape.circle,

                            ),

                            child:
                                const Icon(

                              Icons.lock_rounded,

                              color:
                                  Colors.white,

                              size:
                                  50,

                            ),

                          ),

                        ),

                      ),

                    ),

                ],

              ),

            ),

          ),

        ),

      ),

    );
  }
}