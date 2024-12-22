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
    connection.handleProtocolEvents(data, onMouseMove: (data) {
      double x = data.x;
      double y = data.y;
      double sense = data.intensity;

      return mouse.move(x, y, sense);
    }, onMouseScroll: (data) {
      mouse.scroll(
        data.x.sign.ceil(),
        data.y.sign.ceil(),
        data.intensity.round(),
      );
    }, onMouseClick: (data) {
      mouse.click(data.type);
    });
  }

  interpretEvents(dynamic data) {
    final protocol = Protocol.fromJson(jsonDecode(data));

    final event = protocol.event;

    if (ALLOW_PRINTING && kDebugMode) {
      debugPrint(event.toString());
      debugPrint(protocol.data.toString());
      debugPrint(protocol.timestamp.toString());
    }

    // switch (event) {
    //   case ProtocolEvent.connectionInfo:
    //     {
    //       final data = ConnectionInfoProtocolData.fromJson(protocol.data);
    //       connection.updateConnectionInfo(data);
    //     }
    //   case ProtocolEvent.connectionStatus:
    //     // TODO: Handle this case.
    //     throw UnimplementedError();
    //   case ProtocolEvent.desktopToMobileData:
    //     // TODO: Handle this case.
    //     throw UnimplementedError();
    //   case ProtocolEvent.mobileToDesktopData:
    //     // TODO: Handle this case.
    //     throw UnimplementedError();
    //   case ProtocolEvent.mouseMove:
    //     {}
    //   case ProtocolEvent.mouseCenter:
    //     // TODO: Handle this case.
    //     throw UnimplementedError();
    //   case ProtocolEvent.mouseScroll:
    //     {}
    //   case ProtocolEvent.mouseClick:
    //     {
    //       final data = MouseButtonProtocolData.fromJson(protocol.data);
    //       mouse.click(data.type);
    //     }
    //   case ProtocolEvent.mouseDoubleClick:
    //     {
    //       final data = MouseButtonProtocolData.fromJson(protocol.data);
    //       mouse.doubleClick(data.type);
    //     }
    //   case ProtocolEvent.mouseButtonHold:
    //     {
    //       mouse.holdLeftButton();
    //     }
    //   case ProtocolEvent.mouseButtonReleased:
    //     {
    //       mouse.releaseLeftButton();
    //     }
    //   case ProtocolEvent.keyPressed:
    //     {
    //       final data = protocol.data as String;
    //       keyboard.type(data);
    //     }
    //   case ProtocolEvent.specialKeyPressed:
    //     {
    //       final data = KeyboardProtocolData.fromJson(protocol.data);
    //       keyboard.pressSpecial(data.key);
    //     }
    //   case ProtocolEvent.specialKeyReleased:
    //     {
    //       final data = KeyboardProtocolData.fromJson(protocol.data);
    //       keyboard.releaseSpecial(data.key);
    //     }
    //   case ProtocolEvent.connect:
    //     // TODO: Handle this case.
    //     throw UnimplementedError();
    //   case ProtocolEvent.disconnect:
    //     // TODO: Handle this case.
    //     throw UnimplementedError();
    // }
  }
}
