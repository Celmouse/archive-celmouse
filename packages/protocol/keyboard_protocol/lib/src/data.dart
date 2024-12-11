import 'package:freezed_annotation/freezed_annotation.dart';
import 'special_keys.dart';

part 'data.freezed.dart';
part 'data.g.dart';

@freezed
class KeyboardProtocolData with _$KeyboardProtocolData {
  const factory KeyboardProtocolData({
    required SpecialKeyType key,
  }) = _KeyboardProtocolData;

  factory KeyboardProtocolData.fromJson(Map<String, Object?> json) =>
      _$KeyboardProtocolDataFromJson(json);
}
