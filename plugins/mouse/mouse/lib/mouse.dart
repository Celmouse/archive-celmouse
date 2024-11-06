import 'package:mouse_platform_interface/mouse_platform_interface.dart';

class Mouse {
  void move(double x, double y) => MousePlatform.instance.move(x, y);
  void moveTo(double x, double y) => MousePlatform.instance.moveTo(x, y);
}
