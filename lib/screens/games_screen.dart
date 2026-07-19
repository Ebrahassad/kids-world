import 'package:flutter/material.dart';

import 'progress_manager.dart';

import 'game_screen.dart';
import 'choose_image_screen.dart';
import 'match_image_screen.dart';
import 'colors_screen.dart';
import 'numbers_screen.dart';
import 'letters_screen.dart';
import 'memory_levels_screen.dart';
import 'sort_objects_screen.dart';
import 'puzzle_order_screen.dart';
import 'hard_puzzle_screen.dart';

///==============================
/// بيانات اللعبة
///==============================
class GameItem {
  final String title;
  final String image;
  final Color color;
  final Widget screen;

  const GameItem({
    required this.title,
    required this.image,
    required this.color,
    required this.screen,
  });
}

///==============================
/// قائمة الألعاب
///==============================
const List<GameItem> games = [

  GameItem(
    title: "التعرف على الصور",
    image: "assets/images/games/learn_images.png",
    color: Colors.orange,
    screen: GameScreen(),
  ),

  GameItem(
    title: "اختر الصورة",
    image: "assets/images/games/choose_image.png",
    color: Colors.amber,
    screen: ChooseImageScreen(),
  ),

  GameItem(
    title: "مطابقة الصور",
    image: "assets/images/games/match_images.png",
    color: Colors.indigo,
    screen: MatchImageScreen(),
  ),

  GameItem(
    title: "تعلم الألوان",
    image: "assets/images/games/colors.png",
    color: Colors.pink,
    screen: ColorsScreen(),
  ),

  GameItem(
    title: "تعلم الأرقام",
    image: "assets/images/games/numbers.png",
    color: Colors.teal,
    screen: NumbersScreen(),
  ),

  GameItem(
    title: "تعلم الحروف",
    image: "assets/images/games/letters.png",
    color: Colors.red,
    screen: LettersScreen(),
  ),

  GameItem(
    title: "لعبة الذاكرة",
    image: "assets/images/games/memory.png",
    color: Colors.green,
    screen: MemoryLevelsScreen(),
  ),

  GameItem(
    title: "ترتيب الأشياء",
    image: "assets/images/games/sort_objects.png",
    color: Colors.deepOrange,
    screen: SortObjectsScreen(),
  ),

  GameItem(
    title: "ترتيب الصورة",
    image: "assets/images/games/puzzle_order.png",
    color: Colors.purple,
    screen: PuzzleOrderScreen(),
  ),

  GameItem(
    title: "البازل الصعب",
    image: "assets/images/games/hard_puzzle.png",
    color: Colors.deepPurple,
    screen: HardPuzzleScreen(),
  ),

];