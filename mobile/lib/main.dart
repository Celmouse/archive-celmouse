import 'package:controller/src/features/connect/connect_page.dart';
import 'package:controller/src/features/mouse/move/ui/mouse_move_page.dart';
import 'package:flutter/material.dart';
import 'package:controller/getit.dart';
import 'package:web_socket_channel/web_socket_channel.dart'; // Import the getit.dart file

void main() {
  setup(); // Call the setup function to register dependencies

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Celmouse',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ConnectToServerPage(),
      // home: kDebugMode ? MenuPage() : const ConnectToServerPage(),
      // home: const MoveMousePage(),
    );
  }
}
