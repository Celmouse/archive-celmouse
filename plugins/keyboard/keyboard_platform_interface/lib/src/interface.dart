import 'special_keys.dart';

abstract class KeyboardInterface {
  void pressKey(String key);
  void releaseKey(String key);
  void pressSpecialKey(SpecialKey key);
  void releaseSpecialKey(SpecialKey key);
}
