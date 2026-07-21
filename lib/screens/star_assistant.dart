import 'package:flutter/material.dart';
import '../star_voice_manager.dart';
import 'happy_star.dart';

class StarAssistant extends StatelessWidget {
  const StarAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: StarVoiceManager.talkingNotifier,
      builder: (context, talking, child) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                right: 12,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: HappyStar(
                  key: ValueKey(talking),
                  size: talking ? 95 : 65,
                  idle: !talking,
                  message: talking
                      ? "أنا معك ⭐"
                      : "",
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}