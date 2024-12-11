import 'dart:async';

import 'package:keyboard/keyboard.dart';

class KeyboardService {
  final keyboard = Keyboard();

  void type(String key) {
    keyboard.pressKey(key);
    Timer(const Duration(milliseconds: 200), () {
      keyboard.releaseKey(key);
    });
  }
  
  void typeSpecial(String key){
    keyboard.pressSpecialKey(key)
  }
}
