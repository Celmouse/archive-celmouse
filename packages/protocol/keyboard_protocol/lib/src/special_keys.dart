import 'package:json_annotation/json_annotation.dart';

enum SpecialKeyType {
  @JsonValue('shift')
  shift,
  @JsonValue('space')
  space,
  @JsonValue('backspace')
  backspace,
  @JsonValue('enter')
  enter,
  @JsonValue('specialChars')
  specialChars,
  @JsonValue('defaultLayout')
  defaultLayout,
}
