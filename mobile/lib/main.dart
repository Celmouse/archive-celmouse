import 'package:flutter/material.dart';
import 'package:controller/getit.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'src/config/dependencies.dart'; // Import the getit.dart file

void main() {
  setup(); // Call the setup function to register dependencies

  runApp(
    MultiProvider(
      providers: defaultProvider,
      child: const MyApp(),
    ),
  );
}