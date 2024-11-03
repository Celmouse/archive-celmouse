import 'dart:convert';

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
    required String event,
    required dynamic data,
  }) = _Protocol;

  factory Protocol.fromJson(Map<String, Object?> json) =>
      _$ProtocolFromJson(json);
}

class ProtocolEvents {
  static const keyPressed = "KeyPressed";
  static const changeSensitivity = "ChangeSensitivity";
  static const changeScrollSensitivity = "ChangeScrollSensitivity";
  // Movement
  static const mouseMove = "MouseMove";
  static const mouseCenter = "MouseCenter";
  static const mouseScroll = "MouseScroll";
  // Clicks
  static const mouseClick = "MouseClick";
  static const mouseDoubleClick = "MouseDoubleClick";
  static const mouseButtonPressed = "MouseButtonPressed";
  static const mouseButtonReleased = "MouseButtonReleased";
}

enum ClickType {
  left("left"),
  middle("middle"),
  right("right");

  const ClickType(this.type);

  final String type;
}

class ScrollDirections {
  static const right = "right";
  static const left = "left";
  static const up = "up";
  static const down = "down";
}
