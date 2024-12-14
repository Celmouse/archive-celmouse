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
