import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'games_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
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
      duration: const Duration(
        milliseconds: 1800,
      ),
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


    _controller.repeat(
      reverse: true,
    );


    _loadSettings();

  }



  Future<void> _loadSettings() async {

    final prefs =
        await SharedPreferences.getInstance();


    if (!mounted) return;


    setState(() {

      _soundEnabled =
          prefs.getBool("sound") ?? true;


      _isArabic =
          prefs.getBool("arabic") ?? true;

    });

  }




  Future<void> _saveSettings() async {

    final prefs =
        await SharedPreferences.getInstance();


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

              color:
                  Colors.black.withOpacity(0.18),

            ),

          ),



          SafeArea(

            child: Column(

              children: [

                Expanded(

                  child: SingleChildScrollView(

                    physics:
                        const BouncingScrollPhysics(),


                    child: SizedBox(

                      height:
                          size.height * 0.88,


                      child: Column(

                        children: [


                          // الشريط العلوي

                          Padding(

                            padding:
                                const EdgeInsets.symmetric(

                              horizontal: 18,

                              vertical: 10,

                            ),


                            child: Row(

                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,


                              children: [

                                Container(

                                  decoration:
                                      BoxDecoration(

                                    color: Colors.white
                                        .withOpacity(0.18),


                                    borderRadius:
                                        BorderRadius.circular(16),

                                  ),


                                  child:
                                      IconButton(

                                    icon:
                                        const Icon(

                                      Icons
                                          .language_rounded,

                                      color:
                                          Colors.white,

                                    ),


                                    onPressed:
                                        () async {

                                      setState(() {

                                        _isArabic =
                                            !_isArabic;

                                      });


                                      await _saveSettings();

                                    },

                                  ),

                                ),


                                Row(

                                  children: [

                                    Container(

                                      decoration:
                                          BoxDecoration(

                                        color: Colors.white
                                            .withOpacity(0.18),

                                        borderRadius:
                                            BorderRadius.circular(16),

                                      ),


                                      child:
                                          IconButton(

                                        icon:
                                            Icon(

                                          _soundEnabled

                                              ? Icons
                                                  .volume_up_rounded

                                              : Icons
                                                  .volume_off_rounded,


                                          color:
                                              Colors.white,

                                        ),


                                        onPressed:
                                            () async {

                                          setState(() {

                                            _soundEnabled =
                                                !_soundEnabled;

                                          });


                                          await _saveSettings();

                                        },

                                      ),

                                    ),


                                    const SizedBox(
                                      width: 10,
                                    ),


                                    Container(

                                      decoration:
                                          BoxDecoration(

                                        color: Colors.white
                                            .withOpacity(0.18),

                                        borderRadius:
                                            BorderRadius.circular(16),

                                      ),


                                      child:
                                          IconButton(

                                        icon:
                                            const Icon(

                                          Icons
                                              .settings_rounded,

                                          color:
                                              Colors.white,

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
              const SizedBox(height: 30),

                          // =========================
                          // شعار التطبيق
                          // =========================

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




                          // =========================
                          // اسم التطبيق
                          // =========================


                          const Text(

                            "Kids World",

                            textAlign: TextAlign.center,


                            style: TextStyle(

                              fontSize: 42,

                              fontWeight:
                                  FontWeight.bold,


                              color: Colors.white,


                              letterSpacing: 1.2,


                              shadows: [

                                Shadow(

                                  color:
                                      Colors.black54,

                                  blurRadius: 10,

                                  offset:
                                      Offset(0, 3),

                                ),

                              ],

                            ),

                          ),



                          const SizedBox(height: 8),




                          const Text(

                            "عالم الأطفال",


                            style: TextStyle(

                              fontSize: 28,

                              fontWeight:
                                  FontWeight.bold,


                              color: Colors.white,


                              shadows: [

                                Shadow(

                                  color:
                                      Colors.black45,

                                  blurRadius: 8,

                                ),

                              ],

                            ),

                          ),




                          const SizedBox(height: 20),





                          // بطاقة التعريف

                          Container(

                            padding:
                                const EdgeInsets.symmetric(

                              horizontal: 22,

                              vertical: 10,

                            ),


                            decoration:
                                BoxDecoration(

                              color: Colors.white
                                  .withOpacity(0.18),


                              borderRadius:
                                  BorderRadius.circular(30),

                            ),


                            child: const Text(

                              "⭐ تعلم    🧩 العب    🏆 اجمع النجوم",


                              textAlign:
                                  TextAlign.center,


                              style: TextStyle(

                                color: Colors.white,

                                fontSize: 18,

                                fontWeight:
                                    FontWeight.w600,


                                letterSpacing: 0.5,

                              ),

                            ),

                          ),




                          const SizedBox(height: 55),




                          // =========================
                          // زر البداية
                          // =========================


                          Container(

                            width: 290,

                            height: 66,


                            decoration:
                                BoxDecoration(

                              borderRadius:
                                  BorderRadius.circular(35),


                              gradient:
                                  const LinearGradient(

                                begin:
                                    Alignment.topLeft,


                                end:
                                    Alignment.bottomRight,


                                colors: [

                                  Color(0xff4CAF50),

                                  Color(0xff2E7D32),

                                ],

                              ),



                              boxShadow: [

                                BoxShadow(

                                  color: Colors.green
                                      .withOpacity(.45),


                                  blurRadius: 20,


                                  offset:
                                      const Offset(0, 8),

                                ),

                              ],

                            ),




                            child:
                                ElevatedButton.icon(


                              onPressed:
                                  _openGames,



                              icon:
                                  const Icon(

                                Icons
                                    .play_circle_fill_rounded,


                                color:
                                    Colors.white,


                                size: 34,

                              ),




                              label:
                                  const Text(


                                "ابدأ من هنا",


                                style:
                                    TextStyle(

                                  fontSize: 27,

                                  fontWeight:
                                      FontWeight.bold,


                                  color:
                                      Colors.white,

                                ),

                              ),




                              style:
                                  ElevatedButton.styleFrom(


                                backgroundColor:
                                    Colors.transparent,


                                shadowColor:
                                    Colors.transparent,


                                shape:
                                    RoundedRectangleBorder(


                                  borderRadius:
                                      BorderRadius.circular(35),


                                ),

                              ),

                            ),

                          ),




                          const Spacer(),



                          Padding(

                            padding:
                                const EdgeInsets.only(

                              bottom: 16,

                            ),


                            child: Text(

                              "الإصدار 1.0.0",


                              style: TextStyle(

                                color: Colors.white
                                    .withOpacity(.90),


                                fontSize: 15,


                                fontWeight:
                                    FontWeight.w500,


                                shadows: const [

                                  Shadow(

                                    color:
                                        Colors.black45,


                                    blurRadius: 6,

                                  ),

                                ],

                              ),

                            ),

                          ),
                        ],

                      ),

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





  // =========================
  // نافذة الإعدادات
  // =========================

  void _showSettings() {

    showModalBottomSheet(

      context: context,

      backgroundColor: Colors.transparent,

      isScrollControlled: true,


      builder: (context) {

        return Container(

          decoration: const BoxDecoration(

            color: Colors.white,

            borderRadius: BorderRadius.vertical(

              top: Radius.circular(30),

            ),

          ),


          child: SafeArea(

            child: Padding(

              padding: const EdgeInsets.all(20),


              child: Column(

                mainAxisSize:
                    MainAxisSize.min,


                children: [


                  Container(

                    width: 50,

                    height: 5,


                    decoration: BoxDecoration(

                      color: Colors.grey.shade400,

                      borderRadius:
                          BorderRadius.circular(20),

                    ),

                  ),



                  const SizedBox(height: 20),



                  const Row(

                    mainAxisAlignment:
                        MainAxisAlignment.center,


                    children: [

                      Icon(

                        Icons.settings,

                        color: Colors.blue,

                        size: 30,

                      ),


                      SizedBox(width: 10),


                      Text(

                        "الإعدادات",

                        style: TextStyle(

                          fontSize: 28,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ],

                  ),



                  const SizedBox(height: 25),




                  SwitchListTile(

                    secondary: Icon(

                      _soundEnabled

                          ? Icons.volume_up

                          : Icons.volume_off,


                      color: Colors.green,

                    ),


                    title: const Text(

                      "تشغيل الصوت",

                      style: TextStyle(

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),


                    value: _soundEnabled,


                    onChanged: (value) async {


                      setState(() {

                        _soundEnabled = value;

                      });


                      await _saveSettings();

                    },

                  ),




                  const Divider(),




                  ListTile(

                    leading: const Icon(

                      Icons.language,

                      color: Colors.orange,

                    ),


                    title: const Text(

                      "اللغة",

                      style: TextStyle(

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),


                    subtitle: Text(

                      _isArabic
                          ? "العربية"
                          : "English",

                    ),


                    trailing:
                        const Icon(

                      Icons.arrow_forward_ios,

                    ),


                    onTap: () async {


                      setState(() {

                        _isArabic =
                            !_isArabic;

                      });


                      await _saveSettings();


                    },

                  ),




                  const Divider(),




                  ListTile(

                    leading: const Icon(

                      Icons.info_outline,

                      color: Colors.blue,

                    ),


                    title: const Text(

                      "حول التطبيق",

                      style: TextStyle(

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),


                    trailing:
                        const Icon(

                      Icons.arrow_forward_ios,

                    ),


                    onTap: () {

                      Navigator.pop(context);

                      _showAbout();

                    },

                  ),




                  const Divider(),




                  ListTile(

                    leading: const Icon(

                      Icons.star_rate,

                      color: Colors.amber,

                    ),


                    title: const Text(

                      "تقييم التطبيق",

                    ),


                    trailing:
                        const Icon(

                      Icons.arrow_forward_ios,

                    ),

                    onTap: () {},

                  ),




                  const Divider(),




                  ListTile(

                    leading: const Icon(

                      Icons.email_outlined,

                      color: Colors.red,

                    ),


                    title: const Text(

                      "تواصل معنا",

                    ),


                    trailing:
                        const Icon(

                      Icons.arrow_forward_ios,

                    ),


                    onTap: () {},

                  ),




                  const SizedBox(height: 15),



                  Text(

                    "الإصدار 1.0.0",

                    style: TextStyle(

                      color:
                          Colors.grey.shade600,

                      fontWeight:
                          FontWeight.w600,

                    ),

                  ),



                  const SizedBox(height: 15),


                ],

              ),

            ),

          ),

        );

      },

    );

  }
  // =========================
  // نافذة حول التطبيق
  // =========================

  void _showAbout() {

    showDialog(

      context: context,


      builder: (context) {


        return Dialog(

          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(30),

          ),


          child: Padding(

            padding:
                const EdgeInsets.all(24),


            child: Column(

              mainAxisSize:
                  MainAxisSize.min,


              children: [



                Image.asset(

                  "assets/icon/app_icon.png",

                  width: 110,

                  height: 110,

                ),



                const SizedBox(height: 15),




                const Text(

                  "Kids World",

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight:
                        FontWeight.bold,


                    color: Colors.blue,

                  ),

                ),




                const SizedBox(height: 8),




                const Text(

                  "عالم الأطفال",

                  style: TextStyle(

                    fontSize: 22,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),




                const SizedBox(height: 18),




                const Text(

                  "لعبة تعليمية وترفيهية للأطفال تساعدهم على تعلم الصور والألوان والأرقام والحروف والأشكال من خلال ألعاب ممتعة وآمنة.",


                  textAlign:
                      TextAlign.center,


                  style: TextStyle(

                    fontSize: 16,

                    height: 1.6,

                  ),

                ),




                const SizedBox(height: 25),




                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 18,

                    vertical: 12,

                  ),


                  decoration:
                      BoxDecoration(

                    color:
                        Colors.blue.shade50,


                    borderRadius:
                        BorderRadius.circular(18),

                  ),



                  child: const Column(

                    children: [


                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,


                        children: [

                          Text(

                            "الإصدار",

                            style:
                                TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          ),


                          Text("1.0.0"),

                        ],

                      ),



                      SizedBox(height: 10),



                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,


                        children: [


                          Text(

                            "الفئة",

                            style:
                                TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          ),


                          Text("تعليمي"),


                        ],

                      ),


                    ],

                  ),

                ),




                const SizedBox(height: 20),




                const Text(

                  "© 2026 Kids World",


                  style: TextStyle(

                    color: Colors.grey,


                    fontWeight:
                        FontWeight.bold,

                  ),

                ),




                const SizedBox(height: 20),




                SizedBox(

                  width:
                      double.infinity,


                  child:
                      ElevatedButton(


                    onPressed: () {


                      Navigator.pop(context);


                    },


                    style:
                        ElevatedButton.styleFrom(


                      backgroundColor:
                          Colors.blue,


                      shape:
                          RoundedRectangleBorder(


                        borderRadius:
                            BorderRadius.circular(18),


                      ),

                    ),


                    child:
                        const Text(


                      "إغلاق",


                      style:
                          TextStyle(


                        color:
                            Colors.white,


                        fontSize: 18,


                      ),


                    ),

                  ),

                ),



              ],

            ),

          ),

        );


      },

    );

  }

}