import 'dart:ffi';
import 'mouse_macos_bindings_generated.dart';

import 'package:mouse_platform_interface/mouse_platform_interface.dart';

class MouseMacOS extends MousePlatform {
  static void registerWith() {
    MousePlatform.instance = MouseMacOS();
  }

  @override
  void move(double x, double y) => _bindings.mouseMove(x, y);

  @override
  void moveTo(double x, double y) => _bindings.mouseMoveTo(x, y);

  @override
  (int x, int y) getScreenSize() {
    final size = _bindings.getScreenSize();
    return (size.width, size.height);
  }

  @override
  void pressButton(MouseButton button) =>
      _bindings.mousePressButton(button.value);

  @override
  void releaseButton(MouseButton button) =>
      _bindings.mouseReleaseButton(button.value);

  @override
  void doubleClick() => _bindings.performDoubleClick();

  @override
  void scroll(int x, int y, int amount) => _bindings.mouseScroll(x, y, amount);
}

const String _libName = 'mouse_macos';

/// The dynamic library in which the symbols for [MouseMacosBindings] can be found.
final DynamicLibrary _dylib =
    DynamicLibrary.open('$_libName.framework/$_libName');

/// The bindings to the native functions in [_dylib].
final MouseMacosBindings _bindings = MouseMacosBindings(_dylib);
