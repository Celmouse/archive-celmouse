// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionInfoProtocolData _$ConnectionInfoProtocolDataFromJson(
        Map<String, dynamic> json) =>
    ConnectionInfoProtocolData(
      deviceName: json['deviceName'] as String,
      deviceOS: $enumDecode(_$DeviceOSEnumMap, json['deviceOS']),
      versionNumber: json['versionNumber'] as String,
    );

Map<String, dynamic> _$ConnectionInfoProtocolDataToJson(
        ConnectionInfoProtocolData instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'deviceOS': _$DeviceOSEnumMap[instance.deviceOS]!,
      'versionNumber': instance.versionNumber,
    };

const _$DeviceOSEnumMap = {
  DeviceOS.windows: 'windows',
  DeviceOS.linux: 'linux',
  DeviceOS.macos: 'macos',
  DeviceOS.unknown: 'unknown',
};

DesktopToMobileData _$DesktopToMobileDataFromJson(Map<String, dynamic> json) =>
    DesktopToMobileData(
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$DesktopToMobileDataToJson(
        DesktopToMobileData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };

MobileToDesktopData _$MobileToDesktopDataFromJson(Map<String, dynamic> json) =>
    MobileToDesktopData(
      message: json['message'] as String,
    );

Map<String, dynamic> _$MobileToDesktopDataToJson(
        MobileToDesktopData instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
