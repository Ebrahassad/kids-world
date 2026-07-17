import 'package:shared_preferences/shared_preferences.dart';

class StarManager {

  static const String key = "total_stars";


  // حفظ مجموع النجوم
  static Future<void> addStars(int stars) async {

    final prefs = await SharedPreferences.getInstance();

    int oldStars = prefs.getInt(key) ?? 0;

    await prefs.setInt(
      key,
      oldStars + stars,
    );

  }


  // قراءة مجموع النجوم
  static Future<int> getStars() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;

  }


  // تصفير النجوم (إذا احتجنا)
  static Future<void> resetStars() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      key,
      0,
    );

  }

}