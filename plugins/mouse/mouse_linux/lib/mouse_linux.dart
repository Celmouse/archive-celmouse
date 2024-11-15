import 'dart:ffi';
import 'mouse_linux_bindings_generated.dart';
import 'package:mouse_platform_interface/mouse_platform_interface.dart' as i;

class MouseLinux extends i.MousePlatform {
  static void registerWith() {
    i.MousePlatform.instance = MouseLinux();
  }

  @override
  void move(double x, double y) => _bindings.MouseMove(x, y);

  @override
  void moveTo(double x, double y) => _bindings.MouseMoveTo(x, y);

  @override
  void holdLeftButton() => _bindings.MouseHoldLeftButton();

  @override
  void releaseLeftButton() => _bindings.MouseReleaseLeftButton();

  @override
  void click(i.MouseButton button) => _bindings.MouseClick(button.value);

  @override
  void doubleClick() => _bindings.DoubleClick();

  @override
  void scroll(int x, int y, int amount) => _bindings.MouseScroll(x, y, amount);
}

const String _libName = 'mouse_linux';

/// The dynamic library in which the symbols for [MouseLinuxBindings] can be found.
final DynamicLibrary _dylib = DynamicLibrary.open('lib$_libName.so');

/// The bindings to the native functions in [_dylib].
final MouseLinuxBindings _bindings = MouseLinuxBindings(_dylib);
