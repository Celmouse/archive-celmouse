import 'dart:ffi';

import 'package:keyboard_platform_interface/keyboard_platform_interface.dart';
import 'generated/bindings.dart';

import 'src/special_keys.dart';
import 'src/keys.dart';

class KeyboardMacOS extends KeyboardPlatform {
  static void registerWith() {
    KeyboardPlatform.instance = KeyboardMacOS();
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

  @override
  void pressSpecialKey(SpecialKeyType key) {
    _bindings.pressKeyboardKey(key.code);
  }

  @override
  void releaseSpecialKey(SpecialKeyType key) {
    _bindings.releaseKeyboardKey(key.code);
  }
}

const String _libName = 'keyboard_macos';

/// The dynamic library in which the symbols for [KeyboardMacosBindings] can be found.
final DynamicLibrary _dylib =
    DynamicLibrary.open('$_libName.framework/$_libName');

/// The bindings to the native functions in [_dylib].
final KeyboardMacosBindings _bindings = KeyboardMacosBindings(_dylib);
