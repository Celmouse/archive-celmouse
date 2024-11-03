import 'package:protocol/protocol.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class KeyboardControl {
  final WebSocketChannel channel;

  KeyboardControl(this.channel);

  void type(String text) {
    final data = Protocol(event: Events.keyPressed, data: text);
    _send(data);
  }

  void _send(Protocol data) => channel.sink.add(data.toJson());
}
