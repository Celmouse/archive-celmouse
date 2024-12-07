import 'package:controller/src/ui/connect/view/connect_hub_page.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: ConnectHUBPage(
        viewmodel: ConnectHUBViewmodel(
          connectRepository: context.read(),
        ),
      ),
    );
  }
}
