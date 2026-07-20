import 'package:flutter/material.dart';
import 'happy_star.dart';

class StarCompanion extends StatelessWidget {

  final String message;

  const StarCompanion({
    super.key,
    this.message = "أنا نجمتك ⭐ هيا نلعب!",
  });


  @override
  Widget build(BuildContext context) {

    return Align(

      alignment: Alignment.bottomRight,

      child: Padding(

        padding: const EdgeInsets.all(12),

        child: HappyStar(

          size: 80,

          message: message,

        ),

      ),

    );

  }
}