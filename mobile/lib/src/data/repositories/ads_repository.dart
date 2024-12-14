import 'package:controller/src/data/services/google_ads_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsRepository {
  final GoogleAdsService _googleAdsService;

  AdsRepository({
    required GoogleAdsService googleAdsService,
  }) : _googleAdsService = googleAdsService;

  bool _isAdsInitialized = false;

  Future<BannerAd> fetchBannerAd() async {
    if (!_isAdsInitialized) {
      await _googleAdsService.initializeAds((isInitialized) {
        _isAdsInitialized = isInitialized;
      });
    }
    return await _googleAdsService.loadBanner();
  }
}
