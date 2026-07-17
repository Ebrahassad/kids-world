import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {

  // حفظ رقم السؤال الحالي
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


  // جلب آخر مكان وصل له
  static Future<int> getProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(gameName) ?? 0;

  }


  // مسح تقدم لعبة
  static Future<void> resetProgress(
    String gameName,
  ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(gameName);

  }

}