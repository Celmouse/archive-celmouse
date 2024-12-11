import 'package:mouse/mouse.dart' as plugin;

/// Multipliers to make movement viable
/// [yMultiplier] represents the screen size on the vertical axis.
/// [xMultiplier] represents the screen size on the horizontal axis.
const yMultiplier = 21;
const xMultiplier = 27;

class MouseService {
  final mouse = plugin.Mouse();

  MouseService();

  void move(double x, double y, double sense) => mouse.move(
        x * xMultiplier * sense,
        y * yMultiplier * sense,
      );

  void scroll(int x, int y, int sense) => mouse.scroll(x, y, sense);

  get screenSize => mouse.getScreenSize();

  void click(plugin.MouseButton button) {
    mouse.click(button);
  }

  void doubleClick(plugin.MouseButton button) {
    mouse.doubleClick();
  }

  void holdLeftButton() {
    mouse.holdLeftButton();
  }

  void releaseLeftButton() {
    mouse.releaseLeftButton();
  }
}
