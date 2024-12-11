import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:protocol_interface/protocol_interface.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Protocol with _$Protocol {
  @JsonSerializable(
    explicitToJson: true,
    createToJson: true,
  )
  const factory Protocol({
    required ProtocolEvent event,
    DateTime? timestamp,
    required dynamic data,
  }) = _Protocol;

  factory Protocol.fromJson(Map<String, Object?> json) =>
      _$ProtocolFromJson(json);
}
