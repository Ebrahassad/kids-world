import 'package:flutter/material.dart';

class PuzzleTile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const PuzzleTile({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(1, 2),
              color: Colors.black12,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}