import 'package:freezed_annotation/freezed_annotation.dart';
import 'device_os.dart';

part 'data.freezed.dart';
part 'data.g.dart';

@freezed
class ConnectionInfoProtocolData with _$ConnectionInfoProtocolData {
  const factory ConnectionInfoProtocolData({
    required String deviceName,
    required DeviceOS deviceOS,
    required String versionNumber,
  }) = _ConnectionInfoProtocolData;

  factory ConnectionInfoProtocolData.fromJson(Map<String, Object?> json) =>
      _$ConnectionInfoProtocolDataFromJson(json);
}

@freezed
class DesktopToMobileData with _$DesktopToMobileData {
  const factory DesktopToMobileData({
    required String message,
    required DateTime timestamp,
  }) = _DesktopToMobileData;

  factory DesktopToMobileData.fromJson(Map<String, Object?> json) =>
      _$DesktopToMobileDataFromJson(json);
}

@freezed
class MobileToDesktopData with _$MobileToDesktopData {
  const factory MobileToDesktopData({
    required String message,
  }) = _MobileToDesktopData;

  factory MobileToDesktopData.fromJson(Map<String, Object?> json) =>
      _$MobileToDesktopDataFromJson(json);
}
