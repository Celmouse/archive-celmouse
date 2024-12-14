import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviromentVariables {
  static final String admobAppId = kDebugMode
      ? 'ca-app-pub-3940256099942544~1458002511'
      : dotenv.env['ADMOB_APP_ID'] ?? 'ca-app-pub-3940256099942544~1458002511';
  static final String admobBannerId = kDebugMode
      ? 'ca-app-pub-3940256099942544/2934735716'
      : dotenv.env['ADMOB_BANNER_ID'] ??
          'ca-app-pub-3940256099942544/2934735716';
  static final String admobNativeId = kDebugMode
      ? 'ca-app-pub-3940256099942544/3986624511'
      : dotenv.env['ADMOB_NATIVE_ID'] ??
          'ca-app-pub-3940256099942544/3986624511';
  static final String admobAppIdAndroid = kDebugMode
      ? 'ca-app-pub-3940256099942544~3347511713'
      : dotenv.env['ADMOB_APP_ID_ANDROID'] ??
          'ca-app-pub-3940256099942544~3347511713';
  static final String admobBannerIdAndroid = kDebugMode
      ? 'ca-app-pub-3940256099942544/6300978111'
      : dotenv.env['ADMOB_BANNER_ID_ANDROID'] ??
          'ca-app-pub-3940256099942544/6300978111';
  static final String admobNativeIdAndroid = kDebugMode
      ? 'ca-app-pub-3940256099942544/2247696110'
      : dotenv.env['ADMOB_NATIVE_ID_ANDROID'] ??
          'ca-app-pub-3940256099942544/2247696110';
}
