import 'package:keyboard_protocol/keyboard_protocol.dart';

abstract class KeyboardInterface {
  void pressKey(String key);
  void releaseKey(String key);
  void pressSpecialKey(SpecialKeyType key);
  void releaseSpecialKey(SpecialKeyType key);
}
