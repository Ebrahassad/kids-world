import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {

  static Future<void> saveProgress(
    String gameName,
    int question,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      gameName,
      question,
    );

  }


  static Future<int> getProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(gameName) ?? 0;

  }


  static Future<void> saveCompletedGame(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      "${gameName}_completed",
      true,
    );

  }


  static Future<bool> isGameCompleted(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(
      "${gameName}_completed",
    ) ?? false;

  }


  static Future<void> resetProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(gameName);

  }

}