import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:controller/src/config/enviroment.dart';

class AdManager {
  static final AdManager _instance = AdManager._internal();
  factory AdManager() => _instance;
  AdManager._internal() {
    _configureTestDevice();
    loadRewardedAd(); // Preload the ad during initialization
  }

  RewardedAd? _rewardedAd;
  VoidCallback? onRewardEarned;
  VoidCallback? onAdLoaded;

  String get rewardedAdUnitId {
    return Platform.isAndroid
        ? EnviromentVariables.admobRewardedIdAndroid
        : EnviromentVariables.admobRewardedId;
  }

  void _configureTestDevice() {
    final requestConfiguration = RequestConfiguration(
      testDeviceIds: ['065B54BCE7DA1E8C3D14F610E151507D'],
    );
    MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  }

  Future<void> loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          print('Rewarded ad loaded.');
          if (onAdLoaded != null) {
            onAdLoaded!();
          }
        },
        onAdFailedToLoad: (error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
        },
      ),
    );
  }

  bool get isRewardedAdReady => _rewardedAd != null;

  Future<void> showRewardedAd() async {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          print('Rewarded ad shown.');
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadRewardedAd(); // Reload the ad after it's dismissed
          print('Rewarded ad dismissed.');
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Rewarded ad failed to show: $error');
          ad.dispose();
          loadRewardedAd(); // Reload the ad if it fails to show
        },
      );
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        print('User earned reward: ${reward.amount} ${reward.type}');
        if (onRewardEarned != null) {
          onRewardEarned!();
        }
      }).catchError((error) {
        print('Error showing rewarded ad: $error');
        loadRewardedAd(); // Attempt to load the ad if it fails to show
      });
    } else {
      print('Rewarded ad is not ready yet.');
      await loadRewardedAd(); // Attempt to load the ad if it's not ready
    }
  }
}
