import 'package:mouse_rust/mouse_rust.dart';

class BaseMouse {
  static Future<void> init() => RustLib.init();
}

class BaseMouseMoviment {
  move(double x, double y) => moveMouse(x: x, y: y);
  (int, int) get getPosition => getMousePos();
}
