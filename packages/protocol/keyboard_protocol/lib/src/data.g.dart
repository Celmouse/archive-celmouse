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
  SpecialKeyType.Enter: 'Enter',
  SpecialKeyType.Tab: 'Tab',
  SpecialKeyType.Space: 'Space',
  SpecialKeyType.Backspace: 'Backspace',
  SpecialKeyType.Escape: 'Escape',
  SpecialKeyType.MetaLeft: 'MetaLeft',
  SpecialKeyType.ShiftLeft: 'ShiftLeft',
  SpecialKeyType.ShiftRight: 'ShiftRight',
  SpecialKeyType.CapsLock: 'CapsLock',
  SpecialKeyType.AltLeft: 'AltLeft',
  SpecialKeyType.AltRight: 'AltRight',
  SpecialKeyType.ControlLeft: 'ControlLeft',
  SpecialKeyType.ControlRight: 'ControlRight',
  SpecialKeyType.ArrowLeft: 'ArrowLeft',
  SpecialKeyType.ArrowRight: 'ArrowRight',
  SpecialKeyType.ArrowDown: 'ArrowDown',
  SpecialKeyType.ArrowUp: 'ArrowUp',
};