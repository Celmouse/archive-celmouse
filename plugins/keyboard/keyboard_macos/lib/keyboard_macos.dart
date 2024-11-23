import 'dart:ffi';
import 'generated/bindings.dart';
import 'package:keyboard_platform_interface/keyboard_platform_interface.dart'
    as i;

import 'src/keys.dart';

class KeyboardMacOS extends i.KeyboardPlatform {
  static void registerWith() {
    i.KeyboardPlatform.instance = KeyboardMacOS();
  }

  @override
  void pressKey(String key) {
    assert(key.length == 1);
    final k = KeyCode.fromChar(key)?.code;
    if (k == null) return;
    _bindings.pressKeyboardKey(k);
  }

  @override
  void releaseKey(String key) {
    assert(key.length == 1);
    final k = KeyCode.fromChar(key)?.code;
    if (k == null) return;
    _bindings.releaseKeyboardKey(k);
  }

  @override
  Future<String?> getPlatformVersion() async {
    return "MacOS: 1.0.0";
  }
}

const String _libName = 'keyboard_macos';

/// The dynamic library in which the symbols for [KeyboardMacosBindings] can be found.
final DynamicLibrary _dylib =
    DynamicLibrary.open('$_libName.framework/$_libName');

/// The bindings to the native functions in [_dylib].
final KeyboardMacosBindings _bindings = KeyboardMacosBindings(_dylib);
