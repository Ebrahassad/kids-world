import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {

  // حفظ تقدم اللعبة (رقم السؤال أو المرحلة)
  static Future<void> saveProgress(
    String gameName,
    int value,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      "${gameName}_progress",
      value,
    );

  }


  // جلب تقدم اللعبة
  static Future<int> getProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(
      "${gameName}_progress",
    ) ?? 0;

  }


  // حفظ نجوم اللعبة
  static Future<void> saveStars(
    String gameName,
    int stars,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      "${gameName}_stars",
      stars,
    );

  }


  // جلب نجوم اللعبة
  static Future<int> getStars(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(
      "${gameName}_stars",
    ) ?? 0;

  }


  // حفظ مجموع النجوم لكل الألعاب
  static Future<void> saveTotalStars(
    int stars,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      "total_stars",
      stars,
    );

  }


  // جلب مجموع النجوم
  static Future<int> getTotalStars() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(
      "total_stars",
    ) ?? 0;

  }


  // تسجيل أن اللعبة اكتملت
  static Future<void> saveCompletedGame(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      "${gameName}_completed",
      true,
    );

  }


  // هل اللعبة مكتملة؟
  static Future<bool> isGameCompleted(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(
      "${gameName}_completed",
    ) ?? false;

  }


  // مسح تقدم لعبة
  static Future<void> resetProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(
      "${gameName}_progress",
    );

    await prefs.remove(
      "${gameName}_stars",
    );

    await prefs.remove(
      "${gameName}_completed",
    );

  }

}