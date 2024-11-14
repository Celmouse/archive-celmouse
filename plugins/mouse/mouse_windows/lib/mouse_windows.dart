
import 'dart:ffi';
import 'mouse_windows_bindings_generated.dart';
import 'package:mouse_platform_interface/mouse_platform_interface.dart' as i;


class MouseWindows extends i.MousePlatform {
  static void registerWith() {
    i.MousePlatform.instance = MouseWindows();
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


const String _libName = 'mouse_windows';

/// The dynamic library in which the symbols for [MouseWindowsBindings] can be found.
final DynamicLibrary _dylib = 
     DynamicLibrary.open('$_libName.dll');
 
/// The bindings to the native functions in [_dylib].
final MouseWindowsBindings _bindings = MouseWindowsBindings(_dylib);

