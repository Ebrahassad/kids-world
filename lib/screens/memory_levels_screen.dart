import 'package:flutter/material.dart';
import 'memory_game_screen.dart';
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
    loadUnlockedLevel();
  }

  Future<void> loadUnlockedLevel() async {

    unlockedLevel =
        await ProgressManager.getUnlockedLevel(
      "memory_game",
    );

    if (mounted) {
      setState(() {});
    }
  }

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

            final bool unlocked =
                level <= unlockedLevel;

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
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: InkWell(

                borderRadius:
                    BorderRadius.circular(20),

                onTap: () {

                  if (!unlocked) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content: Text(
                          "🔒 أكمل المستوى السابق أولاً",
                        ),

                      ),

                    );

                    return;
                  }

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          MemoryGameScreen(
                        level: level,
                      ),

                    ),

                  ).then((_) {
                    loadUnlockedLevel();
                  });

                },

                child: Padding(

                  padding:
                      const EdgeInsets.all(12),

                  child: Column(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Icon(

                        unlocked
                            ? Icons.extension
                            : Icons.lock,

                        size: 45,

                        color: unlocked
                            ? Colors.blue
                            : Colors.grey,

                      ),

                      const SizedBox(height: 10),

                      Text(

                        "المستوى $level",

                        style: TextStyle(

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,

                          color: unlocked
                              ? Colors.black
                              : Colors.grey,

                        ),

                      ),

                      const SizedBox(height: 8),

                      Text(

                        difficulty,

                        style: TextStyle(

                          fontSize: 16,

                          color: unlocked
                              ? Colors.black
                              : Colors.grey,

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