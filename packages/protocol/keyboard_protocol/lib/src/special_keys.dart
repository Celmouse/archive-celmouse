import 'package:json_annotation/json_annotation.dart';

enum SpecialKeyType {
  @JsonValue('arrowLeft')
  arrowLeft,
  @JsonValue('arrowRight')
  arrowRight,
  @JsonValue('arrowUp')
  arrowUp,
  @JsonValue('arrowDown')
  arrowDown,
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
  @JsonValue('volumeUp') // Add volume up
  volumeUp,
  @JsonValue('volumeDown') // Add volume down
  volumeDown,
  @JsonValue('volumeMute') // Add volume mute
  volumeMute,
  @JsonValue('fn')
  fn,
}
