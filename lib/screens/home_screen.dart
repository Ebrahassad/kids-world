import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'games_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _logoAnimation;

  bool _soundEnabled = true;
  bool _isArabic = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoAnimation = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _soundEnabled =
          prefs.getBool("sound") ?? true;

      _isArabic =
          prefs.getBool("arabic") ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      "sound",
      _soundEnabled,
    );

    await prefs.setBool(
      "arabic",
      _isArabic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openGames() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const GamesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final size =
        MediaQuery.of(context).size;

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
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.18),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
Expanded(
  child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: SizedBox(
      height: size.height * 0.88,
      child: Column(
        children: [

          /// =========================
          /// الشريط العلوي
          /// =========================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.language_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isArabic = !_isArabic;
                      });

                      await _saveSettings();
                    },
                  ),
                ),

                Row(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: Icon(
                          _soundEnabled
                              ? Icons.volume_up_rounded
                              : Icons.volume_off_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          setState(() {
                            _soundEnabled =
                                !_soundEnabled;
                          });

                          await _saveSettings();
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _showSettings();
                        },
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          /// =========================
          /// شعار التطبيق
          /// =========================

          ScaleTransition(
            scale: _logoAnimation,
            child: Hero(
              tag: "logo",
              child: Image.asset(
                "assets/icon/app_icon.png",
                width: 185,
                height: 185,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 25),
/// =========================
/// اسم التطبيق
/// =========================

const Text(
  "Kids World",
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1.2,
    shadows: [
      Shadow(
        color: Colors.black54,
        blurRadius: 10,
        offset: Offset(0, 3),
      ),
    ],
  ),
),

const SizedBox(height: 8),

const Text(
  "عالم الأطفال",
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Colors.black45,
        blurRadius: 8,
      ),
    ],
  ),
),

const SizedBox(height: 20),

Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 22,
    vertical: 10,
  ),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.18),
    borderRadius: BorderRadius.circular(30),
  ),
  child: const Text(
    "⭐ تعلم    🧩 العب    🏆 اجمع النجوم",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),
),

const SizedBox(height: 55),

/// =========================
/// زر البداية
/// =========================

Container(
  width: 290,
  height: 66,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(35),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff4CAF50),
        Color(0xff2E7D32),
      ],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(.45),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: ElevatedButton.icon(
    onPressed: _openGames,
    icon: const Icon(
      Icons.play_circle_fill_rounded,
      color: Colors.white,
      size: 34,
    ),
    label: const Text(
      "ابدأ من هنا",
      style: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
    ),
  ),
),

const Spacer(),

Padding(
  padding: const EdgeInsets.only(bottom: 16),
  child: Text(
    "الإصدار 1.0.0",
    style: TextStyle(
      color: Colors.white.withOpacity(.90),
      fontSize: 15,
      fontWeight: FontWeight.w500,
      shadows: const [
        Shadow(
          color: Colors.black45,
          blurRadius: 6,
        ),
      ],
    ),
  ),
),