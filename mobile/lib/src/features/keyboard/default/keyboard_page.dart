import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/key.dart';

class KeyboardPage extends StatefulWidget {
  const KeyboardPage({super.key});

  @override
  State<KeyboardPage> createState() => _KeyboardPageState();
}

class _KeyboardPageState extends State<KeyboardPage> {
  final keyItems = [
    '1234567890',
    'qwertyuiop',
    'asdfghjkl',
    'zxcvbnm',
  ];
  List<List<String>> keyRows = [];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    for (int i = 0; i < keyItems.length; i++) {
      keyRows.add(List.from(
        keyItems[i].split('').map<String>(
              (v) => v,
            ),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyWidth = size.width / 15;
    final keyHeight = size.height / 6;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: keyRows
              .map<Row>(
                (v) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: v
                      .map(
                        (k) => KeyboardKeyComponent(
                          value: k,
                          width: keyWidth,
                          height: keyHeight,
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
