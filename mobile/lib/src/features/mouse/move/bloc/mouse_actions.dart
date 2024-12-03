
import 'package:controller/src/features/mouse/socket_mouse.dart';
import 'package:protocol/protocol.dart';

mixin class MouseButton {
  late MouseControl mouse;
  bool isPressed = false;
}

mixin ButtonClick on MouseButton {
  void click(ClickType type) => mouse.click(type);
}

mixin ButtonDoubleClick on MouseButton {
  //TODO: Add logic with the double click timer
  void doubleClick(ClickType type) => mouse.doubleClick(type);
}

mixin ButtonHoldAndRelease on MouseButton {
  //TODO: Add logic on the timer
  void press(ClickType type) => mouse.press(type);

  void release(ClickType type) => mouse.release(type);
}
