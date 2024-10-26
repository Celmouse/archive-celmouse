import 'package:web_socket_channel/web_socket_channel.dart';
import 'protocol.dart';

//TODO: Preciso trazer o threshhold e o samplingPeriod mais próximo daqui.
// Nem que precise criar uma auxiliar (MouseConfigs)

class MouseControl {
  final WebSocketChannel channel;

  MouseControl(this.channel);

  /// Send simple click events.
  ///
  /// ( "right", "left", "middle" )
  void click(String type) {
    final data = Protocol(event: Events.mouseClick, data: type);
    _send(data);
  }

  void doubleClick(String type) {
    final data = Protocol(event: Events.mouseDoubleClick, data: type);
    _send(data);
  }

  void center() {
    final data = Protocol(event: Events.mouseCenter, data: null);
    _send(data);
  }

  void move(double x, double y) {
    final data = Protocol(event: Events.mouseMove, data: {"x": x, "y": y});
    _send(data);
  }

  void scroll(String direction) {
    final data = Protocol(event: Events.mouseScroll, data: {
      "direction": direction,
    });
    _send(data);
  }

  void changeSensitivity(num amount) {
    final data = Protocol(event: Events.changeSensitivity, data: amount);
    _send(data);
  }

  void changeScrollSensitivity(num amount) {
    final data = Protocol(event: Events.changeScrollSensitivity, data: amount);
    _send(data);
  }

  /// Send the protocol data formated as Json to the WebSocket
  _send(Protocol data) => channel.sink.add(data.toJson());
}

enum DoubleClickDelayOptions {
  veryFast(100, "Very Fast"),
  fast(300, "Fast"),
  standard(500, "Default"),
  slow(700, "Slow"),
  verySlow(900, "Very Slow");

  const DoubleClickDelayOptions(this.duration, this.text);
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

  bool keepMovingAfterScroll = false;
}
