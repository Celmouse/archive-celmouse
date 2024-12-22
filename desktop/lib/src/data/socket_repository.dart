import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:protocol/protocol.dart';
import 'package:server/src/data/services/connection_service.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'services/keyboard_service.dart';

const ALLOW_PRINTING = false;

class SocketRepository {
  final MouseService mouse;
  final KeyboardService keyboard;
  final ConnectionService connection;

  SocketRepository({
    required this.mouse,
    required this.keyboard,
    required this.connection,
  });

  createSocket() {
    final socket = connection.createServer();
    dynamic data;
    connection.handleProtocolEvents(
      data,
      onMouseMove: (data) {
        double x = data.x;
        double y = data.y;
        double sense = data.intensity;

        return mouse.move(x, y, sense);
      },
      onMouseScroll: (data) {
        mouse.scroll(
          data.x.sign.ceil(),
          data.y.sign.ceil(),
          data.intensity.round(),
        );
      },
      onMouseClick: (data) {
        mouse.click(data.type);
      },
      onMouseDoubleClick: (data) {
        mouse.doubleClick(data.type);
      },
      onKeyPressed: (data) {
        keyboard.type(data);
      },
      onSpecialKeyPressed: (data) {
        keyboard.pressSpecial(data.key);
      },
      onSpecialKeyReleased: (data) {
        keyboard.releaseSpecial(data.key);
      },
    );
  }

  interpretEvents(dynamic data) {
    final protocol = Protocol.fromJson(jsonDecode(data));

    final event = protocol.event;

    if (ALLOW_PRINTING && kDebugMode) {
      debugPrint(event.toString());
      debugPrint(protocol.data.toString());
      debugPrint(protocol.timestamp.toString());
    }
  }
}
