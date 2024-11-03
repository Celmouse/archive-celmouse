import 'dart:convert';

import 'package:protocol/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MouseControl {
  final WebSocketChannel channel;

  MouseControl(this.channel);

  /// Send simple click events.
  ///
  /// ( "right", "left", "middle" )
  void click(ClickType type) {
    final data = Protocol(event: ProtocolEvents.mouseClick, data: type.type);
    _send(data);
  }

  void press(ClickType type) {
    final data =
        Protocol(event: ProtocolEvents.mouseButtonPressed, data: type.type);
    _send(data);
  }

  void release(ClickType type) {
    final data =
        Protocol(event: ProtocolEvents.mouseButtonReleased, data: type.type);
    _send(data);
  }

  void doubleClick(ClickType type) {
    final data =
        Protocol(event: ProtocolEvents.mouseDoubleClick, data: type.type);
    _send(data);
  }

  void center() {
    const data = Protocol(event: ProtocolEvents.mouseCenter, data: null);
    _send(data);
  }

  void move(double x, double y) {
    if (x == 0 && y == 0) return;
    final data =
        Protocol(event: ProtocolEvents.mouseMove, data: {"x": x, "y": y});
    print(data.toJson());
    _send(data);
  }

  void scroll(String direction) {
    final data = Protocol(event: ProtocolEvents.mouseScroll, data: {
      "direction": direction,
    });
    _send(data);
  }

  void changeSensitivity(num amount) {
    final data =
        Protocol(event: ProtocolEvents.changeSensitivity, data: amount);
    _send(data);
  }

  void changeScrollSensitivity(num amount) {
    final data =
        Protocol(event: ProtocolEvents.changeScrollSensitivity, data: amount);
    _send(data);
  }

  /// Send the protocol data formated as Json to the WebSocket
  _send(Protocol data) => channel.sink.add(jsonEncode(data.toJson()));
}

enum DoubleClickDelayOptions {
  veryFast(100, "Very Fast"),
  fast(200, "Fast"),
  standard(300, "Default"),
  slow(500, "Slow"),
  verySlow(700, "Very Slow");

  const DoubleClickDelayOptions(this.duration, this.text);
  final int duration;
  final String text;
}

enum DragStartDelayOptions {
  veryFast(100, "Very Fast"),
  fast(180, "Fast"),
  standard(250, "Default"),
  slow(500, "Slow"),
  verySlow(700, "Very Slow");

  const DragStartDelayOptions(this.duration, this.text);
  final int duration;
  final String text;
}

enum ReduceVibrationOptions {
  strong(0.04, "Hard"),
  standard(0.031, "Default"),
  weak(0.023, "Weak"),
  veryWeak(0.013, "Very weak");

  const ReduceVibrationOptions(this.threshhold, this.text);
  final double threshhold;
  final String text;
}

class MouseConfigs {
  /// Threshhold helps reducing shakiness
  double threshhold = ReduceVibrationOptions.standard.threshhold;
  //  = 0.023; //0.031;
  // static const double threshholdY = 0.023; //0.031;

  static const double scrollThreshholdX = 0.15;
  static const double scrollThreshholdY = 0.15;

  /// Same as samplingPeriod, trying to reduce the input lag could cause communication noises
  /// Value calculated in ms
  static const int inputLag = 15;

  bool invertedPointerX = false;
  bool invertedPointerY = false;

  bool invertedScrollX = false;
  bool invertedScrollY = false;

  int sensitivity = 5;
  int scrollSensitivity = 3;

  int doubleClickDelayMS = DoubleClickDelayOptions.standard.duration;
  int dragStartDelayMS = DragStartDelayOptions.standard.duration;

  bool keepMovingAfterScroll = false;
}
