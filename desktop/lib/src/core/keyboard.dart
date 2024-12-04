import 'package:keyboard/keyboard.dart' as plugin;

class Keyboard {
  final keyboard = plugin.Keyboard();

  pressKey(String key)=> keyboard.pressKey(key);
  releaseKey(String key)=> keyboard.releaseKey(key);
}