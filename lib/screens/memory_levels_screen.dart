import 'package:flutter/material.dart';

import 'memory_screen.dart';
import 'progress_manager.dart';

class MemoryLevelsScreen extends StatefulWidget {
  const MemoryLevelsScreen({super.key});

  @override
  State<MemoryLevelsScreen> createState() =>
      _MemoryLevelsScreenState();
}

class _MemoryLevelsScreenState
    extends State<MemoryLevelsScreen> {

  int unlockedLevel = 1;

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {
    unlockedLevel =
        await ProgressManager.getUnlockedLevel(
      "memory_game",
    );

    if (unlockedLevel < 1) {
      unlockedLevel = 1;
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.lightBlue.shade50,

      appBar: AppBar(

        title: const Text(
          "مراحل لعبة الذاكرة 🧠",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        backgroundColor: Colors.blue,

      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: GridView.builder(

          itemCount: 10,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,

            crossAxisSpacing: 15,

            mainAxisSpacing: 15,

            childAspectRatio: 1.2,

          ),

          itemBuilder: (context, index) {

            final level = index + 1;

            final unlocked =
                level <= unlockedLevel;

            return ElevatedButton(

              style: ElevatedButton.styleFrom(

                backgroundColor: unlocked
                    ? Colors.white
                    : Colors.grey.shade300,

                foregroundColor: unlocked
                    ? Colors.blue
                    : Colors.grey,

                elevation: unlocked ? 5 : 1,

                shape: RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(20),

                ),

              ),

              onPressed: unlocked
                  ? () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              MemoryGameScreen(
                            level: level,
                          ),

                        ),

                      );

                    }
                  : null,

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(

                    unlocked
                        ? Icons.extension
                        : Icons.lock,

                    size: 40,

                  ),

                  const SizedBox(height: 10),

                  Text(

                    "المستوى $level",

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                ],

              ),

            );

          },

        ),

      ),

    );

  }

}