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
  final _channel = MousePlatformChannel();

  void move(double x, double y, double sense) => _channel.move(
        x * xMultiplier * sense,
        y * yMultiplier * sense,
      );

  void scroll(int x, int y, int sense) => _channel.scroll(
        (x * sense).toDouble(),
        (y * sense).toDouble(),
      );

  // get screenSize => mouse.getScreenSize();

  void click(MouseButton button) => _channel.click();

  void doubleClick(MouseButton button) => _channel.doubleClick();

  void holdLeftButton() => _channel.hold(0);

  void releaseLeftButton() => _channel.release(0);
}

class MousePlatformChannel {
  static const platform = MethodChannel('com.celmouse.plugins/mouse');

  void move(double x, double y) => platform.invokeMethod<Map>(
        'move',
        {'x': x, 'y': y},
      );
  void scroll(double x, double y) => platform.invokeMethod<Map>(
        'scroll',
        {'x': x, 'y': y},
      );

  void click() => platform.invokeMethod('click');
  void doubleClick() => platform.invokeMethod('doubleClick');
  void hold(int button) => platform.invokeMethod('holdButton', button);
  void release(int button) => platform.invokeMethod('releaseButton', button);
}
