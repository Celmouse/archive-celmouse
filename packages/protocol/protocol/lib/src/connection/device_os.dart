import 'package:json_annotation/json_annotation.dart';

enum DeviceOS {
  @JsonValue("windows")
  windows,
  @JsonValue("linux")
  linux,
  @JsonValue("macos")
  macos,
  @JsonValue("unknown")
  unknown;
}
