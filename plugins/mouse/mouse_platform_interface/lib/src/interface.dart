import 'types.dart';

abstract class MouseMovement {
  void move(double x, double y);
  void moveTo(double x, double y);
  (int, int) getScreenSize();

  void click(MouseButton button);
  void holdLeftButton();
  void releaseLeftButton();

  void doubleClick();

  void scroll(int x, int y, int amount);
}
