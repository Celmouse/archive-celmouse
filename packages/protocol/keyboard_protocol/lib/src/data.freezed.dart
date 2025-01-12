// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KeyboardProtocolData _$KeyboardProtocolDataFromJson(Map<String, dynamic> json) {
  return _KeyboardProtocolData.fromJson(json);
}

/// @nodoc
mixin _$KeyboardProtocolData {
  SpecialKeyType get key => throw _privateConstructorUsedError;

  /// Serializes this KeyboardProtocolData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyboardProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyboardProtocolDataCopyWith<KeyboardProtocolData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyboardProtocolDataCopyWith<$Res> {
  factory $KeyboardProtocolDataCopyWith(KeyboardProtocolData value,
          $Res Function(KeyboardProtocolData) then) =
      _$KeyboardProtocolDataCopyWithImpl<$Res, KeyboardProtocolData>;
  @useResult
  $Res call({SpecialKeyType key});
}

/// @nodoc
class _$KeyboardProtocolDataCopyWithImpl<$Res,
        $Val extends KeyboardProtocolData>
    implements $KeyboardProtocolDataCopyWith<$Res> {
  _$KeyboardProtocolDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyboardProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as SpecialKeyType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyboardProtocolDataImplCopyWith<$Res>
    implements $KeyboardProtocolDataCopyWith<$Res> {
  factory _$$KeyboardProtocolDataImplCopyWith(_$KeyboardProtocolDataImpl value,
          $Res Function(_$KeyboardProtocolDataImpl) then) =
      __$$KeyboardProtocolDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SpecialKeyType key});
}

/// @nodoc
class __$$KeyboardProtocolDataImplCopyWithImpl<$Res>
    extends _$KeyboardProtocolDataCopyWithImpl<$Res, _$KeyboardProtocolDataImpl>
    implements _$$KeyboardProtocolDataImplCopyWith<$Res> {
  __$$KeyboardProtocolDataImplCopyWithImpl(_$KeyboardProtocolDataImpl _value,
      $Res Function(_$KeyboardProtocolDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of KeyboardProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$KeyboardProtocolDataImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as SpecialKeyType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyboardProtocolDataImpl implements _KeyboardProtocolData {
  const _$KeyboardProtocolDataImpl({required this.key});

  factory _$KeyboardProtocolDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyboardProtocolDataImplFromJson(json);

  @override
  final SpecialKeyType key;

  @override
  String toString() {
    return 'KeyboardProtocolData(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyboardProtocolDataImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  /// Create a copy of KeyboardProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyboardProtocolDataImplCopyWith<_$KeyboardProtocolDataImpl>
      get copyWith =>
          __$$KeyboardProtocolDataImplCopyWithImpl<_$KeyboardProtocolDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyboardProtocolDataImplToJson(
      this,
    );
  }
}

abstract class _KeyboardProtocolData implements KeyboardProtocolData {
  const factory _KeyboardProtocolData({required final SpecialKeyType key}) =
      _$KeyboardProtocolDataImpl;

  factory _KeyboardProtocolData.fromJson(Map<String, dynamic> json) =
      _$KeyboardProtocolDataImpl.fromJson;

  @override
  SpecialKeyType get key;

  /// Create a copy of KeyboardProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyboardProtocolDataImplCopyWith<_$KeyboardProtocolDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
