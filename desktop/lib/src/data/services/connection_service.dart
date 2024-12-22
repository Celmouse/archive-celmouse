import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:protocol/protocol.dart';
import 'package:device_info_plus/device_info_plus.dart';

const ALLOW_PRINTING = false;

class ConnectionService {
  Future<HttpServer> createServer() => HttpServer.bind('0.0.0.0', 7771);

  List<String> getAvailableIPs() {
    final availableIPs = <String>[];
    NetworkInterface.list().then((ips) {
      for (var i in ips) {
        for (var a in i.addresses) {
          availableIPs.add(a.address);
        }
      }
    });
    return availableIPs;
  }

  handleProtocolEvents(
    dynamic eventData, {
    required Function(MouseMovementProtocolData) onMouseMove,
    required Function(MouseMovementProtocolData) onMouseScroll,
    required Function(MouseButtonProtocolData) onMouseClick,
    required Function(MouseButtonProtocolData) onMouseDoubleClick,
    required Function(String) onKeyPressed,
    required Function(KeyboardProtocolData) onSpecialKeyPressed,
    required Function(KeyboardProtocolData) onSpecialKeyReleased,
  }) {
    final protocol = Protocol.fromJson(jsonDecode(eventData));
    final event = protocol.event;

    if (ALLOW_PRINTING && kDebugMode) {
      debugPrint(event.toString());
      debugPrint(protocol.data.toString());
      debugPrint(protocol.timestamp.toString());
    }

    switch (event) {
      case ProtocolEvent.connectionInfo:
        {
          // final data = ConnectionInfoProtocolData.fromJson(protocol.data);
          // connection.updateConnectionInfo(data);
        }
      case ProtocolEvent.connectionStatus:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProtocolEvent.desktopToMobileData:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProtocolEvent.mobileToDesktopData:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProtocolEvent.mouseMove:
        {
          final data = MouseMovementProtocolData.fromJson(protocol.data);

          return onMouseMove(data);
        }
      case ProtocolEvent.mouseCenter:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProtocolEvent.mouseScroll:
        {
          final data = MouseMovementProtocolData.fromJson(protocol.data);

          return onMouseScroll(data);
        }
      case ProtocolEvent.mouseClick:
        {
          final data = MouseButtonProtocolData.fromJson(protocol.data);

          return onMouseClick(data);
        }
      case ProtocolEvent.mouseDoubleClick:
        {
          final data = MouseButtonProtocolData.fromJson(protocol.data);

          return onMouseDoubleClick(data);
        }
      case ProtocolEvent.mouseButtonHold:
        {
          throw UnimplementedError();

          // mouse.holdLeftButton();
        }
      case ProtocolEvent.mouseButtonReleased:
        {
          throw UnimplementedError();

          // mouse.releaseLeftButton();
        }
      case ProtocolEvent.keyPressed:
        {
          final data = protocol.data as String;

          return onKeyPressed(data);
        }
      case ProtocolEvent.specialKeyPressed:
        {
          final data = KeyboardProtocolData.fromJson(protocol.data);

          return onSpecialKeyPressed(data);
        }
      case ProtocolEvent.specialKeyReleased:
        {
          final data = KeyboardProtocolData.fromJson(protocol.data);

          return onSpecialKeyReleased(data);
        }
      case ProtocolEvent.connect:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ProtocolEvent.disconnect:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  static Future<ConnectionInfoProtocolData> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isWindows) {
      final windowsInfo = await deviceInfoPlugin.windowsInfo;
      return ConnectionInfoProtocolData(
        deviceName: windowsInfo.computerName,
        deviceOS: DeviceOS.windows,
        versionNumber: windowsInfo.displayVersion,
      );
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfoPlugin.linuxInfo;
      return ConnectionInfoProtocolData(
        deviceName: linuxInfo.name,
        deviceOS: DeviceOS.linux,
        versionNumber: linuxInfo.version ?? 'Unknown',
      );
    } else if (Platform.isMacOS) {
      final macOsInfo = await deviceInfoPlugin.macOsInfo;
      return ConnectionInfoProtocolData(
        deviceName: macOsInfo.model,
        deviceOS: DeviceOS.macos,
        versionNumber: macOsInfo.osRelease,
      );
    } else {
      return const ConnectionInfoProtocolData(
        deviceName: 'Unknown',
        deviceOS: DeviceOS.unknown,
        versionNumber: 'Unknown',
      );
    }
  }

  void updateConnectionInfo(ConnectionInfoProtocolData data) {
    // send data to the host phone
    print('Device Name: ${data.deviceName}');
    print('Device OS: ${data.deviceOS}');
    print('Version Number: ${data.versionNumber}');
  }
}
