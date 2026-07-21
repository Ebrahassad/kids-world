import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';


class RewardAdManager {


  // ضع معرف إعلان المكافأة التجريبي أثناء التطوير
  static const String rewardAdUnitId =
      'ca-app-pub-3940256099942544/5224354917';


  static RewardedAd? _rewardedAd;



  // تحميل الإعلان
  static void loadRewardAd() {


    RewardedAd.load(

      adUnitId: rewardAdUnitId,

      request: const AdRequest(),

      rewardedAdLoadCallback:

      RewardedAdLoadCallback(


        onAdLoaded: (ad) {

          _rewardedAd = ad;

        },


        onAdFailedToLoad: (error) {

          _rewardedAd = null;

          debugPrint(
            "Reward Ad Error: $error",
          );

        },


      ),

    );


  }





  // عرض الإعلان وإرجاع هل حصل الطفل على المكافأة
  static Future<bool> showRewardAd() async {


    if (_rewardedAd == null) {

      loadRewardAd();

      return false;

    }


    bool rewarded = false;



    await _rewardedAd!.show(

      onUserEarnedReward:
          (ad, reward) {


        rewarded = true;


      },

    );



    _rewardedAd = null;


    loadRewardAd();



    return rewarded;


  }


}