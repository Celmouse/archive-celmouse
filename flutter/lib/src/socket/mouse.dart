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

  void center() {
    final data = Protocol(event: Events.mouseCenter, data: null);
    _send(data);
  }

  void move(double x, double y) {
    final data = Protocol(event: Events.mouseMove, data: {"x": x, "y": y});
    _send(data);
  }

  void scroll(String direction, double intensity) {
    final data = Protocol(event: Events.mouseScroll, data: {
      "direction": direction,
      "intensity": intensity,
    });
    _send(data);
  }

  void changeSensitivity(num amount) {
    final data = Protocol(event: Events.changeSensitivity, data: amount);
    _send(data);
  }

  /// Send the protocol data formated as Json to the WebSocket
  _send(Protocol data) => channel.sink.add(data.toJson());
}

class MouseConfigs {
  /// Threshhold helps reducing shakiness
  static const double threshholdX = 0.031;
  static const double threshholdY = 0.031;

  static const double scrollThreshholdX = 0.15;
  static const double scrollThreshholdY = 0.15;

  /// Same as samplingPeriod, trying to reduce the input lag could cause communication noises
  /// Value calculated in ms
  static const int inputLag = 15;

  static const double scrollIntensityX = 8;
  static const double scrollIntensityY = 10;
  static const bool invertedScroll = false;
}
