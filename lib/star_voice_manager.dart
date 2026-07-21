import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class StarVoiceManager {

  StarVoiceManager._();


  static final AudioPlayer _player = AudioPlayer();


  static bool _isTalking = false;

  static bool get isTalking => _isTalking;


  static String currentVoice = "";


  static String currentScreen = "";


  static final ValueNotifier<bool> talkingNotifier =
      ValueNotifier(false);



  // تغيير الشاشة الحالية
  static void setScreen(String screen){

    currentScreen = screen;

  }



  // إيقاف الصوت
  static Future<void> stop() async {

    await _player.stop();

    _isTalking = false;

    talkingNotifier.value = false;

  }




  // تشغيل الصوت
  static Future<void> _play(String fileName) async {


    if(_isTalking){

      await stop();

    }


    try{


      currentVoice = fileName;


      _isTalking = true;

      talkingNotifier.value = true;



      await _player.play(

        AssetSource(
          "sounds/star/$fileName",
        ),

      );



      _player.onPlayerComplete.first.then((_) {


        _isTalking = false;

        talkingNotifier.value = false;


      });



    }

    catch(e){


      debugPrint(
        "Star Voice Error: $e",
      );


      _isTalking = false;

      talkingNotifier.value = false;

    }

  }




  // تشغيل مباشر
  static Future<void> play(String fileName) async {

    await _play(fileName);

  }




  
  // ⭐ الحديث العام عند الضغط على النجمة
static Future<void> generalTalk() async {
  await _play("general_talk.mp3");
}




  // تشغيل صوت الشاشة الحالية
  static Future<void> screenTalk() async {


    switch(currentScreen){


      case "games":

        await _play(
          "games_talk.mp3",
        );

        break;



      case "memory":

        await _play(
          "memory_talk.mp3",
        );

        break;



      case "levels":

        await _play(
          "levels_talk.mp3",
        );

        break;



      case "win":

        await _play(
          "win_talk.mp3",
        );

        break;



      default:

        await generalTalk();

    }

  }





  // ⭐ الترحيب
  static Future<void> welcome() async {

    await _play(
      "welcome.mp3",
    );

  }



  // 🎮 اختيار اللعبة
  static Future<void> chooseGame() async {

    await _play(
      "choose_game.mp3",
    );

  }




  // 🏆 الفوز
  static Future<void> win() async {

    await _play(
      "star_win.mp3",
    );

  }




  // ⭐ النجوم
  static Future<void> stars() async {

    await _play(
      "stars.mp3",
    );

  }





  // 👏 التشجيع
  static Future<void> great() async {

    await _play(
      "great.mp3",
    );

  }





  // 💡 التلميح
  static Future<void> hint() async {

    await _play(
      "hint.mp3",
    );

  }




  // 🔓 فتح
  static Future<void> unlock() async {

    await _play(
      "unlock.mp3",
    );

  }




  // 👋 وداع
  static Future<void> goodbye() async {

    await _play(
      "goodbye.mp3",
    );

  }




  static String winMessage(){

    return
    "رائع! أحسنت 👏⭐ حصلت على نجوم جديدة، هل أنت مستعد للمرحلة القادمة؟";

  }

}