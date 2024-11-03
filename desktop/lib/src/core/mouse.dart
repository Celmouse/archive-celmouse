import 'package:mouse/mouse.dart' as mouse;

class Mouse {
  void moveMouse(int x, int y) {
    final pos = mouse.getMousePosition();
    x = pos.x + (x * 20);
    y = pos.y + (y * 20);
    // print('x: $x, y: $y');
    mouse.moveMouse(x, y);
  }
}
