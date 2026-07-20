import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class StarVoiceManager {
  StarVoiceManager._();

  static final AudioPlayer _player = AudioPlayer();

  // هل النجمة تتحدث؟
  static bool _isTalking = false;

  static bool get isTalking => _isTalking;

  // إشعار للشاشات عند بدء وانتهاء الكلام
  static final ValueNotifier<bool> talkingNotifier =
      ValueNotifier(false);

  static Future<void> stop() async {
    await _player.stop();

    _isTalking = false;
    talkingNotifier.value = false;
  }

  static Future<void> _play(String fileName) async {
    try {
      // إيقاف أي صوت سابق
      await _player.stop();

      // بدء الكلام
      _isTalking = true;
      talkingNotifier.value = true;

      await _player.play(
        AssetSource("sounds/star/$fileName"),
      );

      // عند انتهاء الصوت
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

  // ⭐ الترحيب
  static Future<void> welcome() async {
    await _play("welcome.mp3");
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

  // 🎁 فتح لعبة جديدة
  static Future<void> unlock() async {
    await _play("unlock.mp3");
  }

  // 👋 الوداع
  static Future<void> goodbye() async {
    await _play("goodbye.mp3");
  }
}