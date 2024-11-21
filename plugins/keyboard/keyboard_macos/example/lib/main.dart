import 'package:flutter/material.dart';
import 'dart:async';

import 'package:keyboard_macos/keyboard_macos.dart' as keyboard_macos;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isPressed = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Timer.periodic(const Duration(seconds: 1), (t) {
            // print("zzz");
            // if (_isPressed) {
            // } else {
            //   // keyboard_macos.releaseKey("z");
            // }
            _isPressed = !_isPressed;
          keyboard_macos.KeyboardMacOS().pressKey(0x00);
          });
        }),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                spacerSmall,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
