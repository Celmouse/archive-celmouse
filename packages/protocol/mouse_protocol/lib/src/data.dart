import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mouse_protocol/src/button_type.dart';

part 'data.freezed.dart';
part 'data.g.dart';


@freezed
class MouseButtonProtocolData with _$MouseButtonProtocolData {
  const factory MouseButtonProtocolData({
    required MouseButton type,
  }) = _MouseButtonProtocolData;

  factory MouseButtonProtocolData.fromJson(Map<String, Object?> json) =>
      _$MouseButtonProtocolDataFromJson(json);
}

@freezed
class MouseMovementProtocolData with _$MouseMovementProtocolData {
  const factory MouseMovementProtocolData({
    required double x,
    required double y,
    required double intensity,
  }) = _MouseMovementProtocolData;

  factory MouseMovementProtocolData.fromJson(Map<String, Object?> json) =>
      _$MouseMovementProtocolDataFromJson(json);
}

