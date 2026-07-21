import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class StarVoiceManager {
  StarVoiceManager._();

  static final AudioPlayer _player = AudioPlayer();

  // هل نجمتك تتحدث الآن؟
  static bool _isTalking = false;

  static bool get isTalking => _isTalking;

  // آخر صوت تم تشغيله
  static String currentVoice = "";

  // إشعار للشاشات
  static final ValueNotifier<bool> talkingNotifier =
      ValueNotifier(false);

  // إيقاف أي صوت
  static Future<void> stop() async {
    await _player.stop();

    _isTalking = false;
    talkingNotifier.value = false;
  }

  // تشغيل أي ملف صوتي
  static Future<void> _play(String fileName) async {

    if (_isTalking) {
      await stop();
    }

    try {

      currentVoice = fileName;

      _isTalking = true;
      talkingNotifier.value = true;

      await _player.play(
        AssetSource("sounds/star/$fileName"),
      );

      _player.onPlayerComplete.first.then((_) {
        _isTalking = false;
        talkingNotifier.value = false;
      });

    } catch (e) {

      debugPrint("Star Voice Error: $e");

      _isTalking = false;
      talkingNotifier.value = false;
    }
  }

  // تشغيل أي ملف صوتي جديد
  static Future<void> play(String fileName) async {
    await _play(fileName);
  }

  // ⭐ الترحيب
  static Future<void> welcome() async {
    await _play("welcome.mp3");
  }

// 🎮 اختيار اللعبة
static Future<void> chooseGame() async {
  await _play("choose_game.mp3");
}

  // 🏆 الفوز
  static Future<void> win() async {
    await _play("star_win.mp3");
  }

  // ⭐ النجوم
  static Future<void> stars() async {
    await _play("stars.mp3");
  }

  // 👏 التشجيع
  static Future<void> great() async {
    await _play("great.mp3");
  }
// 💡 التلميح
static Future<void> hint() async {
  await _play("hint.mp3");
}

  // 🔓 فتح لعبة
  static Future<void> unlock() async {
    await _play("unlock.mp3");
  }

  // 👋 الوداع
  static Future<void> goodbye() async {
    await _play("goodbye.mp3");

  }

// 💬 رسالة الفوز
static String winMessage() {

  return "رائع! أحسنت 👏⭐ حصلت على نجوم جديدة، هل أنت مستعد للمرحلة القادمة؟";

}
}
