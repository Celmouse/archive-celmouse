// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProtocolImpl _$$ProtocolImplFromJson(Map<String, dynamic> json) =>
    _$ProtocolImpl(
      event: $enumDecode(_$ProtocolEventEnumMap, json['event']),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      data: json['data'],
    );

Map<String, dynamic> _$$ProtocolImplToJson(_$ProtocolImpl instance) =>
    <String, dynamic>{
      'event': _$ProtocolEventEnumMap[instance.event]!,
      'timestamp': instance.timestamp?.toIso8601String(),
      'data': instance.data,
    };

const _$ProtocolEventEnumMap = {
  ProtocolEvent.connect: 'ConnectionConnect',
  ProtocolEvent.disconnect: 'ConnectionDisconnect',
  ProtocolEvent.ping: 'ConnectionPing',
  ProtocolEvent.mouseMove: 'MouseMove',
  ProtocolEvent.mouseCenter: 'MouseCenter',
  ProtocolEvent.mouseScroll: 'MouseScroll',
  ProtocolEvent.mouseClick: 'MouseClick',
  ProtocolEvent.mouseDoubleClick: 'MouseDoubleClick',
  ProtocolEvent.mouseButtonHold: 'MouseButtonHold',
  ProtocolEvent.mouseButtonReleased: 'MouseButtonReleased',
  ProtocolEvent.keyPressed: 'keyPressed',
  ProtocolEvent.specialKeyPressed: 'specialKeyPressed',
  ProtocolEvent.specialKeyReleased: 'specialKeyReleased',
};
