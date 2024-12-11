import 'package:json_annotation/json_annotation.dart';

enum ClickType {
  @JsonValue("left")
  left,
  @JsonValue("right")
  right,
  @JsonValue("center")
  center;
}
