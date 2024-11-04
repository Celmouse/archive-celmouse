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
  }) = _Protocol;

  factory Protocol.fromJson(Map<String, Object?> json) =>
      _$ProtocolFromJson(json);
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
