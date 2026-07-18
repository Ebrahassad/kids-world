import 'package:flutter/material.dart';
import 'memory_game_screen.dart';

class MemoryLevelsScreen extends StatelessWidget {
  const MemoryLevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "مراحل لعبة الذاكرة 🧠",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
            childAspectRatio: 1.1,
          ),

          itemBuilder: (context, index) {

            final level = index + 1;

            String difficulty;

            if (level <= 3) {
              difficulty = "🟢 سهل";
            } else if (level <= 6) {
              difficulty = "🟡 متوسط";
            } else {
              difficulty = "🔴 صعب";
            }

            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: InkWell(
                borderRadius: BorderRadius.circular(20),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MemoryGameScreen(
                        level: level,
                      ),
                    ),
                  );
                },

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Icon(
                        Icons.extension,
                        size: 45,
                        color: Colors.blue,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "المستوى $level",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        difficulty,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}