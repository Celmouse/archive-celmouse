import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:protocol/protocol.dart';
import 'package:server/src/data/models/device_info_model.dart';

class ConnectionService {
  static Future<DeviceInfo> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isWindows) {
      final windowsInfo = await deviceInfoPlugin.windowsInfo;
      return DeviceInfo(
        deviceName: windowsInfo.computerName,
        deviceOS: DeviceOS.windows,
        versionNumber: windowsInfo.displayVersion,
      );
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfoPlugin.linuxInfo;
      return DeviceInfo(
        deviceName: linuxInfo.name,
        deviceOS: DeviceOS.linux,
        versionNumber: linuxInfo.version ?? 'Unknown',
      );
    } else if (Platform.isMacOS) {
      final macOsInfo = await deviceInfoPlugin.macOsInfo;
      return DeviceInfo(
        deviceName: macOsInfo.model,
        deviceOS: DeviceOS.macos,
        versionNumber: macOsInfo.osRelease,
      );
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
