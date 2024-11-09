import 'package:mouse_platform_interface/mouse_platform_interface.dart';
export 'package:mouse_platform_interface/src/types.dart';

class Mouse extends MousePlatform {
  @override
  void move(double x, double y) => MousePlatform.instance.move(x, y);
  @override
  void moveTo(double x, double y) => MousePlatform.instance.moveTo(x, y);
  @override
  (int, int) getScreenSize() => MousePlatform.instance.getScreenSize();
  @override
  void click(MouseButton button) => MousePlatform.instance.click(button);
  @override
  void holdLeftButton() => MousePlatform.instance.holdLeftButton(); //Ta aq
  @override
  void releaseLeftButton() => MousePlatform.instance.releaseLeftButton();
  @override
  void doubleClick() => MousePlatform.instance.doubleClick();
  @override
  void scroll(int x, int y, int amount) =>
      MousePlatform.instance.scroll(x, y, amount);
}
