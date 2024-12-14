import 'dart:io';

import 'package:controller/src/config/enviroment.dart';

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
