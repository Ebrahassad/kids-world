import 'package:flutter/material.dart';
import 'star_manager.dart';

class StarBar extends StatefulWidget {
  const StarBar({super.key});

  @override
  State<StarBar> createState() => _StarBarState();
}

class _StarBarState extends State<StarBar> {

  int stars = 0;

  @override
  void initState() {
    super.initState();
    loadStars();
  }

  Future<void> loadStars() async {
    stars = await StarManager.getStars();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.amber.shade600,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: 28,
          ),

          const SizedBox(width: 8),

          Text(
            "$stars",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

        ],
      ),
    );
  }
}