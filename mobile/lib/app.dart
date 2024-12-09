import 'package:controller/src/UI/menu.dart';
import 'package:controller/src/features/connect/connect_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      // home: const ConnectToServerPage(),
      // home: kDebugMode ? const MenuPage() : const ConnectToServerPage(),
      home: const ConnectToServerPage(),
      // home: MoveMousePage(
      //   channel: WebSocketChannel.connect(
      //     Uri.parse('ws://192.168.1.10:7771'),
      //   ),
      // ),
    );
  }
}
