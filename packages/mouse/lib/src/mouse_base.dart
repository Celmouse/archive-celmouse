import 'package:mouse_rust/mouse_rust.dart';

class MouseBase {
  static Future<void> init() => RustLib.init();
}

class Mouse {
  move() => greet(name: 'Teste');
}
