import 'package:json_annotation/json_annotation.dart';

import 'device_os.dart';

part 'data.g.dart';

@JsonSerializable()
class ConnectionInfoProtocolData  {
  final String deviceName;
  final DeviceOS deviceOS;
  final String versionNumber;

  ConnectionInfoProtocolData({
    required this.deviceName,
    required this.deviceOS,
    required this.versionNumber,
  });

  factory ConnectionInfoProtocolData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionInfoProtocolDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionInfoProtocolDataToJson(this);
}

@JsonSerializable()
class DesktopToMobileData {
  final String message;
  final DateTime timestamp;
  DesktopToMobileData({
    required this.message,
    required this.timestamp,
  });

  factory DesktopToMobileData.fromJson(Map<String, Object?> json) =>
      _$DesktopToMobileDataFromJson(json);

  Map<String, Object?> toJson() => _$DesktopToMobileDataToJson(this);
}

@JsonSerializable()
class MobileToDesktopData {
  final String message;
  MobileToDesktopData({
    required this.message,
  });

  factory MobileToDesktopData.fromJson(Map<String, Object?> json) =>
      _$MobileToDesktopDataFromJson(json);

  Map<String, Object?> toJson() => _$MobileToDesktopDataToJson(this);
}
