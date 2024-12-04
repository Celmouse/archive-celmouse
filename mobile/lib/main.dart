import 'package:controller/src/UI/connect/connect_server.dart';
import 'package:controller/src/features/layouts/builder/page.dart';
import 'package:flutter/material.dart';

void main() {
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
      home:  LayoutBuilderPage(),
      // home: kDebugMode ? MenuPage() :  const ConnectToServerPage(),
      // home: MoveMousePage(
      //   channel: WebSocketChannel.connect(
      //     Uri.parse('ws://192.168.1.10:7771'),
      //   ),
      // ),
    );
  }
}
