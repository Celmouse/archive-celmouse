class DeviceInfo {
  final String version;
  final String deviceName;
  final String deviceOS;

  DeviceInfo({
    required this.version,
    required this.deviceName,
    required this.deviceOS,
  });

  factory DeviceInfo.fromMap(Map<String, String> map) {
    return DeviceInfo(
      version: map['version'] ?? 'Unknown',
      deviceName: map['deviceName'] ?? 'Unknown',
      deviceOS: map['deviceOS'] ?? 'Unknown',
    );
  }

  Map<String, String> toMap() {
    return {
      'version': version,
      'deviceName': deviceName,
      'deviceOS': deviceOS,
    };
  }
}
