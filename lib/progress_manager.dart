import 'package:shared_preferences/shared_preferences.dart';


class ProgressManager {


  static const String totalStarsKey =
      "total_stars";


  static const String gamesPlayedKey =
      "games_played";



  // ==================================
  // الحصول على SharedPreferences
  // ==================================

  static Future<SharedPreferences> _prefs() async {

    return await SharedPreferences.getInstance();

  }





  // ==================================
  // حفظ تقدم اللعبة
  // ==================================

  static Future<void> saveProgress(
    String gameName,
    int value,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setInt(

      "${gameName}_progress",

      value,

    );


  }




  static Future<int> getProgress(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          "${gameName}_progress",

        ) ??
        0;


  }






  // ==================================
  // النجوم الخاصة باللعبة
  // ==================================


  static Future<void> saveStars(
    String gameName,
    int stars,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setInt(

      "${gameName}_stars",

      stars,

    );


  }





  static Future<int> getStars(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          "${gameName}_stars",

        ) ??
        0;


  }






  // ==================================
  // مجموع نجوم التطبيق كامل
  // ==================================


  static Future<void> addTotalStars(
    int stars,
  ) async {


    final prefs =
        await _prefs();



    final current =

        prefs.getInt(
          totalStarsKey,
        ) ??
        0;



    await prefs.setInt(

      totalStarsKey,

      current + stars,

    );


  }




  static Future<int> getTotalStars()
  async {


    final prefs =
        await _prefs();



    return prefs.getInt(
          totalStarsKey,
        ) ??
        0;


  }






  // ==================================
  // حفظ اللعبة المكتملة
  // ==================================


  static Future<void> saveCompletedGame(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setBool(

      "${gameName}_completed",

      true,

    );


  }





  static Future<bool> isGameCompleted(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getBool(

          "${gameName}_completed",

        ) ??
        false;


  }






  // ==================================
  // حفظ آخر مستوى لعب فيه الطفل
  // ==================================


  static Future<void> saveLastLevel(
    String gameName,
    int level,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setInt(

      "${gameName}_last_level",

      level,

    );


  }





  static Future<int> getLastLevel(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          "${gameName}_last_level",

        ) ??
        1;


  }
  // ==================================
  // نظام فتح المراحل
  // ==================================


  static Future<void> saveUnlockedLevel(
    String gameName,
    int level,
  ) async {


    final prefs =
        await _prefs();



    final currentLevel =

        prefs.getInt(

              "${gameName}_unlocked_level",

            ) ??

            1;



    if(level > currentLevel){


      await prefs.setInt(

        "${gameName}_unlocked_level",

        level,

      );


    }


  }





  static Future<int> getUnlockedLevel(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          "${gameName}_unlocked_level",

        ) ??
        1;


  }







  // ==================================
  // حفظ مستوى مكتمل
  // ==================================


  static Future<void> saveCompletedLevel(
    String gameName,
    int level,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setBool(

      "${gameName}_level_${level}",

      true,

    );


  }






  static Future<bool> isLevelCompleted(
    String gameName,
    int level,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getBool(

          "${gameName}_level_${level}",

        ) ??
        false;


  }







  // ==================================
  // عدد مرات الفوز
  // ==================================


  static Future<void> addWinCount(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    final count =

        prefs.getInt(

              "${gameName}_wins",

            ) ??

            0;



    await prefs.setInt(

      "${gameName}_wins",

      count + 1,

    );


  }






  static Future<int> getWinCount(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          "${gameName}_wins",

        ) ??
        0;


  }







  // ==================================
  // إعادة الجولة فقط
  // لا تحذف فتح المراحل
  // ==================================


  static Future<void> resetGameRound(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    await prefs.remove(

      "${gameName}_progress",

    );



  }







  // ==================================
  // حذف تقدم لعبة كاملة
  // يستخدم للاختبار فقط
  // ==================================


  static Future<void> resetProgress(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



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



    await prefs.remove(

      "${gameName}_last_level",

    );



    await prefs.remove(

      "${gameName}_wins",

    );




    for(int i = 1; i <= 100; i++){


      await prefs.remove(

        "${gameName}_level_$i",

      );


    }


  }
  // ==================================
  // حذف كل بيانات التطبيق
  // يستخدم عند إعادة ضبط اللعبة بالكامل
  // ==================================


  static Future<void> resetAllData() async {


    final prefs =
        await _prefs();



    await prefs.clear();


  }







  // ==================================
  // حفظ حالة الصوت
  // ==================================


  static Future<void> saveSoundEnabled(
    bool enabled,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setBool(

      "sound_enabled",

      enabled,

    );


  }





  static Future<bool> isSoundEnabled()
  async {


    final prefs =
        await _prefs();



    return prefs.getBool(

          "sound_enabled",

        ) ??

        true;


  }







  // ==================================
  // حفظ اسم آخر لعبة لعبها الطفل
  // ==================================


  static Future<void> saveLastGame(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setString(

      "last_game",

      gameName,

    );


  }





  static Future<String?> getLastGame()
  async {


    final prefs =
        await _prefs();



    return prefs.getString(

      "last_game",

    );


  }







  // ==================================
  // حفظ تقدم عام للطفل
  // مثال:
  // عدد الألعاب المفتوحة
  // ==================================


  static Future<void> saveGamesOpened(
    int count,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setInt(

      "games_opened",

      count,

    );


  }





  static Future<int> getGamesOpened()
  async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          "games_opened",

        ) ??

        0;


  }







  // ==================================
  // زيادة عدد الألعاب التي تم لعبها
  // ==================================


  static Future<void> increaseGamesPlayed()
  async {


    final prefs =
        await _prefs();



    final current =

        prefs.getInt(

              gamesPlayedKey,

            ) ??

            0;



    await prefs.setInt(

      gamesPlayedKey,

      current + 1,

    );


  }





  static Future<int> getGamesPlayed()
  async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          gamesPlayedKey,

        ) ??

        0;


  }
  // ==================================
  // حفظ أعلى نتيجة للعبة
  // ==================================


  static Future<void> saveBestScore(
    String gameName,
    int score,
  ) async {


    final prefs =
        await _prefs();



    final oldScore =

        prefs.getInt(

              "${gameName}_best_score",

            ) ??

            0;



    if(score > oldScore){


      await prefs.setInt(

        "${gameName}_best_score",

        score,

      );


    }


  }





  static Future<int> getBestScore(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getInt(

          "${gameName}_best_score",

        ) ??

        0;


  }







  // ==================================
  // حفظ آخر تاريخ لعب
  // ==================================


  static Future<void> saveLastPlayed(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    await prefs.setString(

      "${gameName}_last_played",

      DateTime.now()
          .toString(),

    );


  }





  static Future<String?> getLastPlayed(
    String gameName,
  ) async {


    final prefs =
        await _prefs();



    return prefs.getString(

      "${gameName}_last_played",

    );


  }







  // ==================================
  // تنظيف الموارد
  // ==================================


  static Future<void> removeKey(
    String key,
  ) async {


    final prefs =
        await _prefs();



    await prefs.remove(

      key,

    );


  }



}