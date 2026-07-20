import 'package:shared_preferences/shared_preferences.dart';

class StarManager {
  static const String key = "total_stars";

  // قراءة الرصيد
  static Future<int> getStars() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  // إضافة نجوم
  static Future<void> addStars(int stars) async {
    final prefs = await SharedPreferences.getInstance();

    final current =
        prefs.getInt(key) ?? 0;

    await prefs.setInt(
      key,
      current + stars,
    );
  }

  // خصم نجوم
  static Future<bool> spendStars(int stars) async {
    final prefs = await SharedPreferences.getInstance();

    final current =
        prefs.getInt(key) ?? 0;

    if (current < stars) {
      return false;
    }

    await prefs.setInt(
      key,
      current - stars,
    );

    return true;
  }

  // تعيين الرصيد مباشرة
  static Future<void> setStars(int stars) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      key,
      stars,
    );
  }

  // تصفير الرصيد
  static Future<void> resetStars() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      key,
      0,
    );
  }
}