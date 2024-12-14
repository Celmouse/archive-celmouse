import 'dart:io';

import 'package:controller/src/config/enviroment.dart';

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

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return EnviromentVariables.admobNativeIdAndroid;
    } else if (Platform.isIOS) {
      return EnviromentVariables.admobNativeId;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
