import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class RewardAdManager {


  static const String rewardAdUnitId =
      'ca-app-pub-3940256099942544/5224354917';


  static RewardedAd? _rewardedAd;



  static Future<void> loadRewardAd() async {


    await RewardedAd.load(

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





  static Future<bool> showRewardAd() async {


    if (_rewardedAd == null) {

      await loadRewardAd();

    }



    if (_rewardedAd == null) {

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