// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MouseButtonProtocolDataImpl _$$MouseButtonProtocolDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MouseButtonProtocolDataImpl(
      type: $enumDecode(_$MouseButtonEnumMap, json['type']),
    );

Map<String, dynamic> _$$MouseButtonProtocolDataImplToJson(
        _$MouseButtonProtocolDataImpl instance) =>
    <String, dynamic>{
      'type': _$MouseButtonEnumMap[instance.type]!,
    };

const _$MouseButtonEnumMap = {
  MouseButton.left: 'left',
  MouseButton.right: 'right',
  MouseButton.center: 'center',
};

_$MouseMovementProtocolDataImpl _$$MouseMovementProtocolDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MouseMovementProtocolDataImpl(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      intensity: (json['intensity'] as num).toDouble(),
    );

Map<String, dynamic> _$$MouseMovementProtocolDataImplToJson(
        _$MouseMovementProtocolDataImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'intensity': instance.intensity,
    };
