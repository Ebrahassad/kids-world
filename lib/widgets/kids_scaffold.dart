import 'package:flutter/material.dart';
import 'star_assistant.dart';

class KidsScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Widget? floatingActionButton;

  const KidsScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          child,

          const Positioned(
            top: 0,
            right: 0,
            child: StarAssistant(),
          ),
        ],
      ),
    );
  }
}