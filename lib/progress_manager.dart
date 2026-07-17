import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {

  // حفظ مكان اللاعب داخل اللعبة
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


  // جلب مكان اللاعب داخل اللعبة
  static Future<int> getProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(gameName) ?? 0;

  }


  // حفظ مجموع النجوم
  static Future<void> saveStars(int stars) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      "total_stars",
      stars,
    );

  }


  // جلب مجموع النجوم
  static Future<int> getStars() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt("total_stars") ?? 0;

  }


  // حفظ اللعبة المكتملة
  static Future<void> saveCompletedGame(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      gameName,
      true,
    );

  }


  // معرفة هل اللعبة مكتملة
  static Future<bool> isGameCompleted(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(gameName) ?? false;

  }


  // مسح تقدم لعبة
  static Future<void> resetProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(gameName);

  }


  // مسح كل التقدم
  static Future<void> resetAll() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

  }

}