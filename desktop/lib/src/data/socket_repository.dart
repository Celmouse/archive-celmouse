import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:protocol/protocol.dart';
import 'package:server/src/data/services/mouse_service.dart';
import 'services/keyboard_service.dart';

const ALLOW_PRINTING = true;

class SocketRepository {
  final MouseService mouse;
  final KeyboardService keyboard;

  SocketRepository({
    required this.mouse,
    required this.keyboard,
  });

  interpretEvents(dynamic data) {
    final protocol = Protocol.fromJson(jsonDecode(data));

    final event = protocol.event.name;

    if (ALLOW_PRINTING && kDebugMode) {
      debugPrint(event);
      debugPrint(protocol.data.toString());
      debugPrint(protocol.timestamp.toString());
    }

    if (event == MouseProtocolEvents.mouseMove.name) {
      final data = MouseMovementProtocolData.fromJson(protocol.data);

      double x = data.x;
      double y = data.y;
      double sense = data.intensity;

      return mouse.move(x, y, sense);
    } else if (event == MouseProtocolEvents.mouseScroll.name) {
      final data = MouseMovementProtocolData.fromJson(protocol.data);

      mouse.scroll(
        data.x.sign.ceil(),
        data.y.sign.ceil(),
        data.intensity.round(),
      );
    } else if (event == MouseProtocolEvents.mouseClick.name) {
      final data = MouseButtonProtocolData.fromJson(protocol.data);
      mouse.click(data.type);
    } else if (event == MouseProtocolEvents.mouseDoubleClick.name) {
      final data = MouseButtonProtocolData.fromJson(protocol.data);
      mouse.doubleClick(data.type);
    } else if (event == MouseProtocolEvents.mouseButtonHold.name) {
      // final data = MouseButtonProtocolData.fromJson(protocol.data);
      mouse.holdLeftButton();
    } else if (event == MouseProtocolEvents.mouseButtonReleased.name) {
      // final data = MouseButtonProtocolData.fromJson(protocol.data);
      mouse.releaseLeftButton();
    } else if (event == KeyboardProtocolEvents.keyPressed.name) {
      final data = protocol.data as String;
      keyboard.type(data);
    } else if (event == KeyboardProtocolEvents.specialKeyPressed.name) {
      final data = KeyboardProtocolData.fromJson(protocol.data);
      keyboard.pressSpecial(data.key);
    } else if (event == KeyboardProtocolEvents.specialKeyReleased.name) {
      final data = KeyboardProtocolData.fromJson(protocol.data);
      keyboard.releaseSpecial(data.key);
    }
  }
}
