enum SpecialKey {
  none,
  space,
}

abstract class ConvertSpecialKey {
  SpecialKey toEnum(int code);
  int toCode(SpecialKey key);
}
