import 'package:controller/src/socket/keyboard.dart';

mixin class KeyboardButton {
  late KeyboardControl keyboard;
  bool isPressed = false;
}

mixin KeyboardButtonHoldAndRelease on KeyboardButton {
  void press(String k) => keyboard.press(k);

  void release(String k) => keyboard.release(k);
}
