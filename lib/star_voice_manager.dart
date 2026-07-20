import 'package:audioplayers/audioplayers.dart';

class StarVoiceManager {
  StarVoiceManager._();

  static final AudioPlayer _player = AudioPlayer();

  static Future<void> stop() async {
    await _player.stop();
  }

  static Future<void> _play(String fileName) async {
    try {
      await _player.stop();

      await _player.play(
        AssetSource("sounds/star/$fileName"),
      );
    } catch (e) {
      print("Star Voice Error: $e");
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

  static Stream<void> get onComplete =>
      _player.onPlayerComplete;
}