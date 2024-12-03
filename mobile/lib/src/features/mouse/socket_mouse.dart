import 'dart:convert';

import 'package:controller/src/core/socket.dart';
import 'package:protocol/protocol.dart';

class MouseControl {
  void click(ClickType type) {
    _send(
      event: ProtocolEvents.mouseClick,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void press(ClickType type) {
    _send(
      event: ProtocolEvents.mouseButtonHold,
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

  void scroll(double x, double y) {
    _send(
      event: ProtocolEvents.mouseScroll,
      data: MouseMovementProtocolData(x: x, y: y),
    );
  }

  @Deprecated('Use scroll instead')
  void performScroll(ScrollDirections direction) {
    _send(
      event: ProtocolEvents.mouseScroll,
      data: MouseScrollProtocolData(direction: direction),
    );
  }

  // TODO: Enviar a sensilibidade do cursor junto com o movimento
  // Multiplicando os valores de x e y pela sensibilidade
  // Lembrar de evitar quebrar o app com versões inconsistentes
  @Deprecated("Sensibilidade do cursor será definida pelo app e será enviada já inclusa no movimento")
  void changeSensitivity(num amount) {
    _send(event: ProtocolEvents.changeSensitivity, data: amount);
  }

  @Deprecated("Sensibilidade do cursor será definida pelo app e será enviada já inclusa no movimento")
  void changeScrollSensitivity(int amount) {
    _send(event: ProtocolEvents.changeScrollSensitivity, data: amount);
  }

  /// Send the protocol data formated as Json to the WebSocket
  _send({
    required ProtocolEvents event,
    required dynamic data,
  }) =>
  //TODO: Cache this getSocket method to improve performance
      SocketConnection().getSocketConnection().sink.add(jsonEncode(
        Protocol(
          event: event,
          data: data,
          timestamp: DateTime.timestamp(),
        ).toJson(),
      ));
}
