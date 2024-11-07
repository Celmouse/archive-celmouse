import 'package:mouse_platform_interface/mouse_platform_interface.dart';
export 'package:mouse_platform_interface/src/types.dart';

class Mouse {
  void move(double x, double y) => MousePlatform.instance.move(x, y);
  void moveTo(double x, double y) => MousePlatform.instance.moveTo(x, y);

  (int, int) getScreenSize() => MousePlatform.instance.getScreenSize();

  void pressButton(MouseButton button) =>
      MousePlatform.instance.pressButton(button);
  
  void releaseButton(MouseButton button) =>
      MousePlatform.instance.releaseButton(button);
}
