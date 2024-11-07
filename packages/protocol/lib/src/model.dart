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
    required DateTime timestamp,
    required dynamic data,
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
  //TODO: Talvez possa implementar o movimento do scroll aqui
  const factory MouseMovementProtocolData({
    required double x,
    required double y,
  }) = _MouseMovementProtocolData;

  factory MouseMovementProtocolData.fromJson(Map<String, Object?> json) =>
      _$MouseMovementProtocolDataFromJson(json);
}

@freezed
class MouseScrollProtocolData with _$MouseScrollProtocolData {
  const factory MouseScrollProtocolData({
    required ScrollDirections direction,
  }) = _MouseScrollProtocolData;

  factory MouseScrollProtocolData.fromJson(Map<String, Object?> json) =>
      _$MouseScrollProtocolDataFromJson(json);
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
  @JsonValue("right")
  right,
  @JsonValue("center")
  center;
}

enum ScrollDirections {
  up("up"), // -y
  left("left"), // -x
  right("right"), // +x
  down("down"); // +y

  const ScrollDirections(this.value);

  final String value;
}

extension EScrollDirection on MouseScrollProtocolData {
  (int x, int y) fromProtocolData() {
    switch (direction) {
      case ScrollDirections.left:
        return (-1, 0);
      case ScrollDirections.up:
        return (0, -1);
      case ScrollDirections.right:
        return (1, 0);
      case ScrollDirections.down:
        return (0, 1);
    }
  }
}
