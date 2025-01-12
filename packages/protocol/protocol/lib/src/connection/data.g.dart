// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionInfoProtocolDataImpl _$$ConnectionInfoProtocolDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionInfoProtocolDataImpl(
      deviceName: json['deviceName'] as String,
      deviceOS: $enumDecode(_$DeviceOSEnumMap, json['deviceOS']),
      versionNumber: json['versionNumber'] as String,
    );

Map<String, dynamic> _$$ConnectionInfoProtocolDataImplToJson(
        _$ConnectionInfoProtocolDataImpl instance) =>
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

_$DesktopToMobileDataImpl _$$DesktopToMobileDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DesktopToMobileDataImpl(
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DesktopToMobileDataImplToJson(
        _$DesktopToMobileDataImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$MobileToDesktopDataImpl _$$MobileToDesktopDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MobileToDesktopDataImpl(
      message: json['message'] as String,
    );

Map<String, dynamic> _$$MobileToDesktopDataImplToJson(
        _$MobileToDesktopDataImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
