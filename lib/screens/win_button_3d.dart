import 'package:flutter/material.dart';

class WinButton3D extends StatefulWidget {

  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const WinButton3D({

    super.key,

    required this.text,

    required this.icon,

    required this.color,

    required this.onPressed,

  });


  @override
  State<WinButton3D> createState() =>
      _WinButton3DState();

}



class _WinButton3DState
    extends State<WinButton3D> {


  bool pressed = false;


  @override
  Widget build(BuildContext context) {


    return GestureDetector(

      onTapDown: (_) {

        setState(() {

          pressed = true;

        });

      },


      onTapUp: (_) {

        setState(() {

          pressed = false;

        });

        widget.onPressed();

      },


      onTapCancel: () {

        setState(() {

          pressed = false;

        });

      },


      child: AnimatedContainer(

        duration:
            const Duration(milliseconds: 100),


        transform:

            Matrix4.translationValues(

              0,

              pressed ? 6 : 0,

              0,

            ),



        width: 280,

        height: 68,



        decoration: BoxDecoration(

          color:
              widget.color.withOpacity(0.7),


          borderRadius:
              BorderRadius.circular(22),


          boxShadow: [

            BoxShadow(

              color: Colors.black26,

              offset: Offset(
                0,
                pressed ? 2 : 8,
              ),

              blurRadius: 6,

            ),

          ],

        ),



        child: Container(

          margin:
              const EdgeInsets.only(
                bottom: 6,
              ),


          decoration: BoxDecoration(

            color: widget.color,


            borderRadius:
                BorderRadius.circular(22),

          ),



          child: Row(

            mainAxisAlignment:
                MainAxisAlignment.center,


            children: [


              Icon(

                widget.icon,

                size: 32,

                color: Colors.white,

              ),



              const SizedBox(
                width: 12,
              ),



              Text(

                widget.text,


                style: const TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.w900,


                  color:
                      Colors.white,


                  shadows: [

                    Shadow(

                      offset:
                          Offset(0,2),

                      blurRadius:
                          2,

                      color:
                          Colors.black38,

                    ),

                  ],

                ),

              ),


            ],

          ),

        ),

      ),

    );

  }

}