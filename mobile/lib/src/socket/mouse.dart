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
    _send(
      event: ProtocolEvents.mouseClick,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void press(ClickType type) {
    _send(
      event: ProtocolEvents.mouseButtonPressed,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void release(ClickType type) {
    _send(
      event: ProtocolEvents.mouseButtonReleased,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void doubleClick(ClickType type) {
    _send(
      event: ProtocolEvents.mouseDoubleClick,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void center() {
    _send(event: ProtocolEvents.mouseCenter, data: null);
  }

  void move(double x, double y) {
    if (x == 0 && y == 0) return;
    _send(
      event: ProtocolEvents.mouseMove,
      data: MouseMovementProtocolData(x: x, y: y),
    );
  }

  void scroll(String direction) {
    _send(event: ProtocolEvents.mouseScroll, data: {
      "direction": direction,
    });
  }

  void changeSensitivity(num amount) {
    _send(event: ProtocolEvents.changeSensitivity, data: amount);
  }

  void changeScrollSensitivity(num amount) {
    _send(event: ProtocolEvents.changeScrollSensitivity, data: amount);
  }

  /// Send the protocol data formated as Json to the WebSocket
  _send({
    required ProtocolEvents event,
    required dynamic data,
  }) =>
      channel.sink.add(jsonEncode(
        Protocol(
          event: event,
          data: data,
          timestamp: DateTime.timestamp().microsecondsSinceEpoch,
        ).toJson(),
      ));
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
