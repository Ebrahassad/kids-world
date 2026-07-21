import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  // تشغيل AdMob
  await MobileAds.instance.initialize();


  runApp(
    const KidsWorldApp(),
  );

}