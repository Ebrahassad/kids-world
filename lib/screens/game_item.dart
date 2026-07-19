import 'package:flutter/material.dart';

class GameItem {
  final int id;
  final String title;
  final String image;
  final Color color;
  final Widget screen;

  const GameItem({
    required this.id,
    required this.title,
    required this.image,
    required this.color,
    required this.screen,
  });
}