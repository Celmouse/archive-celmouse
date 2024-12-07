import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'src/config/dependencies.dart'; // Import the getit.dart file

void main() {
  DartPingIOS.register();
  runApp(
    MultiProvider(
      providers: defaultProvider,
      child: const MyApp(),
    ),
  );
}