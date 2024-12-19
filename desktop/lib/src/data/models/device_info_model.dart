import 'package:protocol/protocol.dart';

class DeviceInfo {
  final String deviceName;
  final DeviceOS deviceOS;
  final String versionNumber;

  DeviceInfo({
    required this.deviceName,
    required this.deviceOS,
    required this.versionNumber,
  });

  factory DeviceInfo.fromMap(Map<String, String> map) {
    return DeviceInfo(
      deviceName: map['deviceName'] ?? 'Unknown',
      deviceOS: DeviceOS.values.firstWhere(
        (e) => e.toString() == 'DeviceOS.${map['deviceOS']}',
        orElse: () => DeviceOS.unknown,
      ),
      versionNumber: map['versionNumber'] ?? 'Unknown',
    );
  }

  Map<String, String> toMap() {
    return {
      'deviceName': deviceName,
      'deviceOS': deviceOS.toString().split('.').last,
      'versionNumber': versionNumber,
    };
  }
}
