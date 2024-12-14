import 'package:controller/src/data/repositories/ads_repository.dart';
import 'package:controller/src/data/repositories/mouse_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum AdsStatus {
  idle,
  loading,
  loaded,
  error,
}

class MouseViewmodel extends ChangeNotifier {
  final MouseRepository _mouseRepository;
  final AdsRepository _adsRepository;

  MouseViewmodel({
    required MouseRepository mouseRepository,
    required AdsRepository adsRepository,
  })  : _mouseRepository = mouseRepository,
        _adsRepository = adsRepository;

  bool _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;

  bool keyboardOpenClose() {
    _isKeyboardOpen = !_isKeyboardOpen;
    notifyListeners();
    return _isKeyboardOpen;
  }

  void stopMouse() {
    _mouseRepository.disableMovement();
    _mouseRepository.disableScrolling();
  }

  AdsStatus loadingAdsStatus = AdsStatus.idle;

  BannerAd? _banner;
  BannerAd get bannerAd => _banner!;
  
  Future<void> loadAds() async {
    loadingAdsStatus = AdsStatus.loading;
    notifyListeners();

    try {
      _banner = await _adsRepository.fetchBannerAd();
      loadingAdsStatus = AdsStatus.loaded;
      notifyListeners();
    } catch (e) {
      loadingAdsStatus = AdsStatus.error;
      notifyListeners();
    }
  }
}
