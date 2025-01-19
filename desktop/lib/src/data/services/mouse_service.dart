import 'package:flutter/services.dart';
import 'package:mouse/mouse.dart';
import 'package:protocol/protocol.dart';

/// Multipliers to make movement viable
/// [yMultiplier] represents the screen size on the vertical axis.
/// [xMultiplier] represents the screen size on the horizontal axis.
const yMultiplier = 21;
const xMultiplier = 27;

class MouseService {
  final mouse = Mouse();

  MouseService();

  void move(double x, double y, double sense) => mouse.move(
        x * xMultiplier * sense,
        y * yMultiplier * sense,
      );

  void scroll(int x, int y, int sense) => mouse.scroll(x, y, sense);

  get screenSize => mouse.getScreenSize();

  void click(MouseButton button) {
    mouse.click(button);
  }

  void doubleClick(MouseButton button) {
    mouse.doubleClick();
  }

  void holdLeftButton() {
    mouse.holdLeftButton();
  }

  void releaseLeftButton() {
    mouse.releaseLeftButton();
  }
}

class MousePlatformChannel {
  static const platform = MethodChannel('com.celmouse.plugins/mouse');

  void move(double x, double y) async {
    // for (var i = 0; i < 100; i++) {
    //   var x = i;
    //   var y = i;
    final coordinates = {'x': x, 'y': y};
    final result = await platform.invokeMethod<Map>(
      'move',
      coordinates,
    );
    print(result);
    //   await Future.delayed(const Duration(milliseconds: 100));
    // }
  }
}
