import 'dart:async';

import 'package:controller/app.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/config/dependencies.dart'; // Import the getit.dart file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: [
    '36e2a439-001d-4afb-966d-f7221a95cdaa',
    '9785EF7F-73AB-4205-9F95-69C9F7423D94',
    //TODO: [Mathis] Add your test device ID here or send me the IDFA (https://support.google.com/admob/answer/9691433?hl=en#ID)
  ]));
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ...defaultProvider,
      ],
      child: const MyApp(),
    ),
  );
}
