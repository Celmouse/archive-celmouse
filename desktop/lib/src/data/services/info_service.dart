import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:server/src/data/models/device_info_model.dart';

class InfoService {
  static Future<DeviceInfo> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    final platformHandlers = {
      'android': () async {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return {
          'deviceName': androidInfo.model ?? 'Unknown',
          'deviceOS': 'Android ${androidInfo.version.release}',
        };
      },
      'ios': () async {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return {
          'deviceName': iosInfo.name ?? 'Unknown',
          'deviceOS': 'iOS ${iosInfo.systemVersion}',
        };
      },
      'linux': () async {
        final linuxInfo = await deviceInfoPlugin.linuxInfo;
        return {
          'deviceName': linuxInfo.name ?? 'Unknown',
          'deviceOS': 'Linux',
        };
      },
      'macos': () async {
        final macOsInfo = await deviceInfoPlugin.macOsInfo;
        return {
          'deviceName': macOsInfo.model ?? 'Unknown',
          'deviceOS': 'macOS ${macOsInfo.osRelease}',
        };
      },
      'windows': () async {
        final windowsInfo = await deviceInfoPlugin.windowsInfo;
        return {
          'deviceName': windowsInfo.computerName ?? 'Unknown',
          'deviceOS': 'Windows',
        };
      },
    };

    final platform = Platform.operatingSystem;
    final handler = platformHandlers[platform];

    if (handler != null) {
      final info = await handler();
      return DeviceInfo(
        version: '1.0.0',
        deviceName: info['deviceName']!,
        deviceOS: info['deviceOS']!,
      );
    } else {
      return DeviceInfo(
        version: '1.0.0',
        deviceName: 'Unknown',
        deviceOS: 'Unknown',
      );
    }
  }
}
