import 'package:flutter/material.dart';

import '../progress_manager.dart';

import 'game_screen.dart';
import 'choose_image_screen.dart';
import 'match_image_screen.dart';
import 'colors_screen.dart';
import 'numbers_screen.dart';
import 'letters_screen.dart';
import 'memory_levels_screen.dart';
import 'sort_objects_screen.dart';
import 'puzzle_order_screen.dart';
import 'hard_puzzle_screen.dart';
import 'game_card.dart';
import 'game_item.dart';



class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {

  int totalStars = 0;
  int openedGames = 1;
  bool loading = true;

  final List<GameItem> games = [

    GameItem(
      id: 1,
      title: "التعرف على الصورة",
      image: "assets/images/games/learn_images.png",
      color: Colors.orange,
      screen: const GameScreen(),
    ),

    GameItem(
      id: 2,
      title: "اختر الصورة",
      image: "assets/images/games/choose_image.png",
      color: Colors.amber,
      screen: const ChooseImageScreen(),
    ),

    GameItem(
      id: 3,
      title: "مطابقة الصور",
      image: "assets/images/games/match_images.png",
      color: Colors.indigo,
      screen: const MatchImageScreen(),
    ),

    GameItem(
      id: 4,
      title: "الألوان",
      image: "assets/images/games/colors.png",
      color: Colors.pink,
      screen: const ColorsScreen(),
    ),

    GameItem(
      id: 5,
      title: "الأرقام",
      image: "assets/images/games/numbers.png",
      color: Colors.teal,
      screen: const NumbersScreen(),
    ),

    GameItem(
      id: 6,
      title: "الحروف",
      image: "assets/images/games/letters.png",
      color: Colors.red,
      screen: const LettersScreen(),
    ),

    GameItem(
      id: 7,
      title: "لعبة الذاكرة",
      image: "assets/images/games/memory.png",
      color: Colors.green,
      screen: const MemoryLevelsScreen(),
    ),

    GameItem(
      id: 8,
      title: "ترتيب الأشياء",
      image: "assets/images/games/sort_objects.png",
      color: Colors.deepOrange,
      screen: const SortObjectsScreen(),
    ),

    GameItem(
      id: 9,
      title: "ترتيب الصورة",
      image: "assets/images/games/puzzle_order.png",
      color: Colors.purple,
      screen: const PuzzleOrderScreen(),
    ),

    GameItem(
      id: 10,
      title: "البازل الصعب",
      image: "assets/images/games/hard_puzzle.png",
      color: Colors.deepPurple,
      screen: const HardPuzzleScreen(),
    ),
  ];


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    totalStars =
        await ProgressManager.getTotalStars();

    openedGames =
        await ProgressManager.getUnlockedGame();

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _loadData();
  }

  bool _isUnlocked(int gameId) {
    return gameId <= openedGames;
  }

  Future<void> _openGame(GameItem game) async {
    if (!_isUnlocked(game.id)) {
      _showLockedDialog();
      return;
    }

    await ProgressManager.saveLastGame(
  game.title,
);

await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => game.screen,
  ),
);

    await _refreshData();
  }

  void _showLockedDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.lock, color: Colors.orange),
            SizedBox(width: 8),
            Text("اللعبة مقفلة"),
          ],
        ),
        content: const Text(
          "أنهِ اللعبة الحالية أولاً لفتح اللعبة التالية.",
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("حسناً"),
          ),
        ],
      );
    },
  );
}

@override
Widget build(BuildContext context) {
  if (loading) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/background.png",
            fit: BoxFit.cover,
          ),
        ),

        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.12),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),

              const Text(
                "🎮 اختر اللعبة",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 18),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.92),
      borderRadius: BorderRadius.circular(22),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 34,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "النجوم: $totalStars",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "$openedGames / 10",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: openedGames / 10,
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "تم فتح $openedGames من أصل 10 ألعاب",
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
),

const SizedBox(height: 18),

Expanded(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: games.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (context, index) {

  final game = games[index];

  final unlocked = _isUnlocked(game.id);

  return GameCard(
    game: game,
    unlocked: unlocked,
    index: index,
    onTap: () => _openGame(game),
  );
},

     ),
  ),
),
       
             ],
          ),
        ),
      ],
    ),
  );
}

  // ==================================
  // رسالة عند فتح لعبة جديدة
  // ==================================

  void showUnlockMessage(
    String title,
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        behavior:
            SnackBarBehavior.floating,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20),
        ),

        backgroundColor:
            Colors.green,

        content: Row(

          children: [

            const Icon(
              Icons.star,
              color: Colors.yellow,
            ),

            const SizedBox(
              width: 10,
            ),

            Expanded(

              child: Text(

                "تم فتح لعبة جديدة: $title",

                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }



  // ==================================
  // تحديث النجوم بعد الفوز
  // ==================================

  Future<void> updateStars() async {

    final stars =
        await ProgressManager
            .getTotalStars();

    if(mounted){

      setState(() {

        totalStars =
            stars;

      });

    }

  }
  // ==================================
  // الحصول على اسم حفظ ثابت للعبة
  // ==================================

  String getGameKey(GameItem game) {

    return "game_${game.id}";

  }



  // ==================================
  // فتح اللعبة التالية بعد الفوز
  // ==================================

  Future<void> unlockNextGame(
    GameItem game,
  ) async {

    await ProgressManager.unlockNextGame(
      game.id,
    );


    await _refreshData();


    if(game.id < games.length){

      showUnlockMessage(
        games[game.id].title,
      );

    }

  }



  // ==================================
  // هل كل الألعاب مكتملة؟
  // ==================================

  Future<bool> isAllGamesFinished()
  async {

    final result =
        await ProgressManager
            .allGamesCompleted();

    return result;

  }



  // ==================================
  // إعادة تحميل الشاشة بعد العودة
  // ==================================

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

  }



  // ==================================
  // تنظيف الموارد
  // ==================================

  @override
  void dispose() {

    super.dispose();

  }
}