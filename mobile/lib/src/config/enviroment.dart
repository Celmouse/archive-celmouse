import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviromentVariables {
  static final String admobAppId = dotenv.env['ADMOB_APP_ID'] ?? 'ca-app-pub-3940256099942544~1458002511';
  static final String admobBannerId = dotenv.env['ADMOB_BANNER_ID'] ?? 'ca-app-pub-3940256099942544/2934735716';
  static final String admobNativeId = dotenv.env['ADMOB_NATIVE_ID'] ?? 'ca-app-pub-3940256099942544/3986624511';
  static final String admobAppIdAndroid = dotenv.env['ADMOB_APP_ID_ANDROID'] ?? 'ca-app-pub-3940256099942544~3347511713';
  static final String admobBannerIdAndroid = dotenv.env['ADMOB_BANNER_ID_ANDROID'] ?? 'ca-app-pub-3940256099942544/6300978111';
  static final String admobNativeIdAndroid = dotenv.env['ADMOB_NATIVE_ID_ANDROID'] ?? 'ca-app-pub-3940256099942544/2247696110';
}