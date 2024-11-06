import 'dart:ffi';
import 'mouse_macos_bindings_generated.dart';

import 'package:mouse_platform_interface/mouse_platform_interface.dart';

class MouseMacOS extends MousePlatform {
  static void registerWith() {
    MousePlatform.instance = MouseMacOS();
  }

  @override
  void move(double x, double y) => _bindings.mouse_move(x, y);
  @override
  void moveTo(double x, double y) => _bindings.mouse_move(x, y);
}

const String _libName = 'mouse_macos';

/// The dynamic library in which the symbols for [MouseMacosBindings] can be found.
final DynamicLibrary _dylib =
    DynamicLibrary.open('$_libName.framework/$_libName');

/// The bindings to the native functions in [_dylib].
final MouseMacosBindings _bindings = MouseMacosBindings(_dylib);
