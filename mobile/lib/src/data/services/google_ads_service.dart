import 'dart:async';
import 'dart:io';

import 'package:controller/src/config/enviroment.dart';
import 'package:controller/src/data/services/consent_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

typedef OnConsentGatheringCompleteListener = void Function(FormError? error);

class GoogleAdsService {
  final ConsentManager _consentManager = ConsentManager();
  bool _isMobileAdsInitializeCalled = false;
  bool _isPrivacyOptionsRequired = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  Future<void> initializeAds() async {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();

    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: [
        '651c98e0-3e36-4896-89a5-a97019682056',
        '36e2a439-001d-4afb-966d-f7221a95cdaa',
        '9785EF7F-73AB-4205-9F95-69C9F7423D94',
        '065B54BCE7DA1E8C3D14F610E151507D',
      ],
    ));
  }

  void gatherConsent(
      OnConsentGatheringCompleteListener onConsentGatheringCompleteListener) {
    _consentManager.gatherConsent((consentGatheringError) {
      if (consentGatheringError != null) {
        // Consent not obtained in current session.
        debugPrint(
            "${consentGatheringError.errorCode}: ${consentGatheringError.message}");
      }

      // Check if a privacy options entry point is required.
      _getIsPrivacyOptionsRequired();

      // Attempt to initialize the Mobile Ads SDK.
      _initializeMobileAdsSDK();
    });

    // This sample attempts to load ads using consent obtained in the previous session.
    _initializeMobileAdsSDK();
  }

  Future<void> _getIsPrivacyOptionsRequired() async {
    if (await _consentManager.isPrivacyOptionsRequired()) {
      _isPrivacyOptionsRequired = true;
    }
  }

  Future<void> _initializeMobileAdsSDK() async {
    if (_isMobileAdsInitializeCalled) {
      return;
    }

    if (await _consentManager.canRequestAds()) {
      _isMobileAdsInitializeCalled = true;

      // Initialize the Mobile Ads SDK.
      MobileAds.instance.initialize();

      // Load an ad.
      _loadAd();
    }
  }

  void _loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQueryData.fromView(WidgetsBinding.instance.window)
            .size
            .width
            .truncate());

    if (size == null) {
      // Unable to get width of anchored banner.
      return;
    }

    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          _bannerAd = ad as BannerAd;
          _isLoaded = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  BannerAd? get bannerAd => _bannerAd;
  bool get isLoaded => _isLoaded;
  bool get isPrivacyOptionsRequired => _isPrivacyOptionsRequired;

  void showPrivacyOptionsForm(
      OnConsentFormDismissedListener onConsentFormDismissedListener) {
    _consentManager.showPrivacyOptionsForm(onConsentFormDismissedListener);
  }

  void dispose() {
    _bannerAd?.dispose();
  }
}

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      print("KEY ==== ${EnviromentVariables.admobBannerIdAndroid}");
      return EnviromentVariables.admobAppIdAndroid;
    } else if (Platform.isIOS) {
      return EnviromentVariables.admobBannerId;
    } else {
      print("UNSUPPORTED PLATFORM");
      throw UnsupportedError("Unsupported platform");
    }
  }
}
