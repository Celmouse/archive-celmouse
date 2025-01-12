import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviromentVariables {
  static final String admobBannerId = kDebugMode
      ? 'ca-app-pub-3940256099942544/2934735716'
      : dotenv.env['ADMOB_BANNER_ID'] ??
          'ca-app-pub-3940256099942544/2934735716';

  static final String admobBannerIdAndroid = kDebugMode
      ? 'ca-app-pub-3940256099942544/6300978111'
      : dotenv.env['ADMOB_BANNER_ID_ANDROID'] ??
          'ca-app-pub-3940256099942544/6300978111';
}
