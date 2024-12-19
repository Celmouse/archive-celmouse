class DeviceInfo {
  final String deviceName;
  final String deviceOS;
  final String versionNumber;

  DeviceInfo({
    required this.deviceName,
    required this.deviceOS,
    required this.versionNumber,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      deviceName: json['deviceName'],
      deviceOS: json['deviceOS'],
      versionNumber: json['versionNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceName': deviceName,
      'deviceOS': deviceOS,
      'versionNumber': versionNumber,
    };
  }
}
