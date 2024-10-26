import 'dart:convert';

class Protocol {
  final String event;
  final dynamic data;

  Protocol({required this.event, required this.data});

  String toJson() => jsonEncode({"event": event, "data": data});
}

class Events {
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

