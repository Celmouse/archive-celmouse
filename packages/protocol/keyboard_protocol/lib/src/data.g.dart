// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeyboardProtocolDataImpl _$$KeyboardProtocolDataImplFromJson(
        Map<String, dynamic> json) =>
    _$KeyboardProtocolDataImpl(
      key: $enumDecode(_$SpecialKeyTypeEnumMap, json['key']),
    );

Map<String, dynamic> _$$KeyboardProtocolDataImplToJson(
        _$KeyboardProtocolDataImpl instance) =>
    <String, dynamic>{
      'key': _$SpecialKeyTypeEnumMap[instance.key]!,
    };

const _$SpecialKeyTypeEnumMap = {
  SpecialKeyType.arrowLeft: 'arrowLeft',
  SpecialKeyType.arrowRight: 'arrowRight',
  SpecialKeyType.arrowUp: 'arrowUp',
  SpecialKeyType.arrowDown: 'arrowDown',
  SpecialKeyType.shift: 'shift',
  SpecialKeyType.space: 'space',
  SpecialKeyType.backspace: 'backspace',
  SpecialKeyType.enter: 'enter',
  SpecialKeyType.specialChars: 'specialChars',
  SpecialKeyType.defaultLayout: 'defaultLayout',
  SpecialKeyType.volumeUp: 'volumeUp',
  SpecialKeyType.volumeDown: 'volumeDown',
  SpecialKeyType.volumeMute: 'volumeMute',
  SpecialKeyType.fn: 'fn',
};
