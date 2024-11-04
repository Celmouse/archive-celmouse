import 'package:mouse_rust/mouse_rust.dart';

class BaseMouse {
  static Future<void> init() => RustLib.init();
}

class BaseMouseMoviment {
  move(double x, double y) => mouseMove(x: x, y: y);
  // (int, int) get getPosition => getMousePos();
  // click(int value) => mouseClick(value: value);
  // press(int value) => mousePress(value: value);
  // release(int value) => mouseRelease(value: value);
}
