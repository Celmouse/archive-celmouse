import 'package:freezed_annotation/freezed_annotation.dart';
part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Protocol with _$Protocol {
  @JsonSerializable(
    explicitToJson: true,
    createToJson: true,
  )
  const factory Protocol({
    required ProtocolEvents event,
    required dynamic data,
    required int timestamp,
  }) = _Protocol;

  factory Protocol.fromJson(Map<String, Object?> json) =>
      _$ProtocolFromJson(json);
}

@freezed
class MouseButtonProtocolData with _$MouseButtonProtocolData {
  const factory MouseButtonProtocolData({
    required ClickType type,
  }) = _MouseButtonProtocolData;

  factory MouseButtonProtocolData.fromJson(Map<String, Object?> json) =>
      _$MouseButtonProtocolDataFromJson(json);
}

@freezed
class MouseMovementProtocolData with _$MouseMovementProtocolData {
  const factory MouseMovementProtocolData({
    required double x,
    required double y,
  }) = _MouseMovementProtocolData;

  factory MouseMovementProtocolData.fromJson(Map<String, Object?> json) =>
      _$MouseMovementProtocolDataFromJson(json);
}

enum ProtocolEvents {
  keyPressed,
  changeSensitivity,
  changeScrollSensitivity,
  // Movement
  mouseMove,
  mouseCenter,
  mouseScroll,
  // Clicks
  mouseClick,
  mouseDoubleClick,
  mouseButtonPressed,
  mouseButtonReleased,
}

enum ClickType {
  @JsonValue("left")
  left,
  @JsonValue("middle")
  middle,
  @JsonValue("right")
  right;

  String toJson() {
    switch (this) {
      case ClickType.left:
        return "left";
      case ClickType.right:
        return "right";
      case ClickType.middle:
        return "middle";
    }
  }
}

class ScrollDirections {
  static const right = "right";
  static const left = "left";
  static const up = "up";
  static const down = "down";
}
