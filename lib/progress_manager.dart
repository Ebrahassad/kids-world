import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {

  // =========================
  // حفظ تقدم اللعبة
  // =========================

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

  static Future<int> getProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(
          "${gameName}_progress",
        ) ??
        0;
  }

  // =========================
  // حفظ نجوم اللعبة
  // =========================

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

  static Future<int> getStars(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(
          "${gameName}_stars",
        ) ??
        0;
  }

  // =========================
  // مجموع النجوم
  // =========================

  static Future<void> saveTotalStars(
    int stars,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      "total_stars",
      stars,
    );

  }

  static Future<int> getTotalStars() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(
          "total_stars",
        ) ??
        0;
  }

  // =========================
  // اكتمال اللعبة
  // =========================

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
        ) ??
        false;
  }

  // =========================
  // آخر مستوى مفتوح
  // =========================

  static Future<void> saveUnlockedLevel(
    String gameName,
    int level,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    final currentLevel =
        prefs.getInt(
              "${gameName}_unlocked_level",
            ) ??
            1;

    if (level > currentLevel) {

      await prefs.setInt(
        "${gameName}_unlocked_level",
        level,
      );

    }

  }

  static Future<int> getUnlockedLevel(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(
          "${gameName}_unlocked_level",
        ) ??
        1;
  }

  // =========================
  // عدد المستويات المكتملة
  // =========================

  static Future<void> saveCompletedLevel(
    String gameName,
    int level,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      "${gameName}_level_$level",
      true,
    );

  }

  static Future<bool> isLevelCompleted(
    String gameName,
    int level,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(
          "${gameName}_level_$level",
        ) ??
        false;
  }

  // =========================
  // إعادة تعيين تقدم اللعبة
  // =========================

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

    await prefs.remove(
      "${gameName}_unlocked_level",
    );

    // حذف حالة المستويات (حتى 100 مستوى)
    for (int i = 1; i <= 100; i++) {

      await prefs.remove(
        "${gameName}_level_$i",
      );

    }

  }

}