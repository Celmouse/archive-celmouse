import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'src/config/dependencies.dart'; // Import the getit.dart file
import 'src/data/services/google_ads_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final googleAdsService = GoogleAdsService();
  await googleAdsService.initializeAds();

  runApp(
    MultiProvider(
      providers: [
        ...defaultProvider,
        Provider<GoogleAdsService>(create: (_) => googleAdsService),
      ],
      child: const MyApp(),
    ),
  );
}
