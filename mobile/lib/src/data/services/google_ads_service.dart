import 'dart:async';
import 'dart:io';

import 'package:controller/src/config/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

typedef OnConsentGatheringCompleteListener = void Function(FormError? error);

class GoogleAdsService {
  final ConsentManager _consentManager = ConsentManager();

  Completer adReadyCompleter = Completer();

  bool _isMobileAdsInitializeCalled = false;
  bool _isPrivacyOptionsRequired = false;
  BannerAd? _bannerAd;
  // Orientation? _currentOrientation;

  final String _adUnitId = Platform.isAndroid
      ? dotenv.env['ADMOB_BANNER_ID_ANDROID']!
      : dotenv.env['ADMOB_BANNER_ID']!;

  Future<void> initializeAds(Function(bool) onInitializationCompleted) async {
    await MobileAds.instance.initialize();

    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: [
        '651c98e0-3e36-4896-89a5-a97019682056',
        '36e2a439-001d-4afb-966d-f7221a95cdaa',
        '9785EF7F-73AB-4205-9F95-69C9F7423D94',
        '065B54BCE7DA1E8C3D14F610E151507D',
      ],
    ));

    onInitializationCompleted(true);
  }

  void gatherConsent() {
    _consentManager.gatherConsent((consentGatheringError) {
      if (consentGatheringError != null) {
        // Consent not obtained in current session.
        debugPrint(
          "${consentGatheringError.errorCode}: ${consentGatheringError.message}",
        );
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
    }
  }

  Future<BannerAd> loadBanner() async {
    if (_bannerAd == null) {
      _loadAd();
    }

    await adReadyCompleter.future;

    return _bannerAd!;
  }

  void _loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      adReadyCompleter.completeError('Consent not obtained');
      return;
    }

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQueryData.fromView(WidgetsBinding.instance.window)
            .size
            .width
            .truncate());

    if (size == null) {
      adReadyCompleter.completeError(
          'Unable to get width of anchored banner.'); // Unable to get width of anchored banner.
      return;
    }

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          _bannerAd = ad as BannerAd;
          adReadyCompleter.complete();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          adReadyCompleter.completeError('Failed to load an ad: $err');
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
      return EnviromentVariables.admobAppIdAndroid;
    } else if (Platform.isIOS) {
      return EnviromentVariables.admobBannerId;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}

/// The Google Mobile Ads SDK provides the User Messaging Platform (Google's IAB
/// Certified consent management platform) as one solution to capture consent for
/// users in GDPR impacted countries. This is an example and you can choose
/// another consent management platform to capture consent.
class ConsentManager {
  /// Helper variable to determine if the app can request ads.
  Future<bool> canRequestAds() async {
    return await ConsentInformation.instance.canRequestAds();
  }

  /// Helper variable to determine if the privacy options form is required.
  Future<bool> isPrivacyOptionsRequired() async {
    return await ConsentInformation.instance
            .getPrivacyOptionsRequirementStatus() ==
        PrivacyOptionsRequirementStatus.required;
  }

  /// Helper method to call the Mobile Ads SDK to request consent information
  /// and load/show a consent form if necessary.
  void gatherConsent(
      OnConsentGatheringCompleteListener onConsentGatheringCompleteListener) {
    // For testing purposes, you can force a DebugGeography of Eea or NotEea.
    ConsentDebugSettings debugSettings = ConsentDebugSettings(
        // debugGeography: DebugGeography.debugGeographyEea,
        );
    ConsentRequestParameters params =
        ConsentRequestParameters(consentDebugSettings: debugSettings);

    // Requesting an update to consent information should be called on every app launch.
    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      ConsentForm.loadAndShowConsentFormIfRequired((loadAndShowError) {
        // Consent has been gathered.
        onConsentGatheringCompleteListener(loadAndShowError);
      });
    }, (FormError formError) {
      onConsentGatheringCompleteListener(formError);
    });
  }

  /// Helper method to call the Mobile Ads SDK method to show the privacy options form.
  void showPrivacyOptionsForm(
      OnConsentFormDismissedListener onConsentFormDismissedListener) {
    ConsentForm.showPrivacyOptionsForm(onConsentFormDismissedListener);
  }
}
