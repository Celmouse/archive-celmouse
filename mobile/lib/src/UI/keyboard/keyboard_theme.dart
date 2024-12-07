import 'package:flutter/material.dart';

class KeyboardTheme {
  final Color keyColor;
  final Color specialKeyColor;
  final Color aderenceKeyColor;
  final TextStyle textStyle;
  final TextStyle specialTextStyle;
  final TextStyle aderenceTextStyle;
  final double keyHeight;
  final double keyWidth;
  final double keySpacing;

  const KeyboardTheme({
    required this.keyColor,
    required this.specialKeyColor,
    required this.aderenceKeyColor,
    required this.textStyle,
    required this.specialTextStyle,
    required this.aderenceTextStyle,
    required this.keyHeight,
    required this.keyWidth,
    required this.keySpacing,
  });
}

const defaultKeyboardTheme = KeyboardTheme(
  keyColor: Colors.grey,
  specialKeyColor: Colors.red,
  aderenceKeyColor: Colors.yellow,
  textStyle: TextStyle(fontSize: 18, color: Colors.black),
  specialTextStyle: TextStyle(fontSize: 18, color: Colors.white),
  aderenceTextStyle: TextStyle(fontSize: 18, color: Colors.black),
  keyHeight: 60,
  keyWidth: 60,
  keySpacing: 4,
);
