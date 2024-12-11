import 'dart:async';

import 'package:keyboard/keyboard.dart';
import 'package:protocol/protocol.dart';

class KeyboardService {
  final keyboard = Keyboard();

  void type(String key) {
    keyboard.pressKey(key);
    Timer(const Duration(milliseconds: 200), () {
      keyboard.releaseKey(key);
    });
  }

  void pressSpecial(SpecialKeyType key) {
    keyboard.pressSpecialKey(key);
  }

  void releaseSpecial(SpecialKeyType key) {
    keyboard.releaseSpecialKey(key);
  }
}
