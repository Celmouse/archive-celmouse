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

MouseButtonProtocolData _$MouseButtonProtocolDataFromJson(
    Map<String, dynamic> json) {
  return _MouseButtonProtocolData.fromJson(json);
}

/// @nodoc
mixin _$MouseButtonProtocolData {
  MouseButton get type => throw _privateConstructorUsedError;

  /// Serializes this MouseButtonProtocolData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MouseButtonProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MouseButtonProtocolDataCopyWith<MouseButtonProtocolData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MouseButtonProtocolDataCopyWith<$Res> {
  factory $MouseButtonProtocolDataCopyWith(MouseButtonProtocolData value,
          $Res Function(MouseButtonProtocolData) then) =
      _$MouseButtonProtocolDataCopyWithImpl<$Res, MouseButtonProtocolData>;
  @useResult
  $Res call({MouseButton type});
}

/// @nodoc
class _$MouseButtonProtocolDataCopyWithImpl<$Res,
        $Val extends MouseButtonProtocolData>
    implements $MouseButtonProtocolDataCopyWith<$Res> {
  _$MouseButtonProtocolDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MouseButtonProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MouseButton,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MouseButtonProtocolDataImplCopyWith<$Res>
    implements $MouseButtonProtocolDataCopyWith<$Res> {
  factory _$$MouseButtonProtocolDataImplCopyWith(
          _$MouseButtonProtocolDataImpl value,
          $Res Function(_$MouseButtonProtocolDataImpl) then) =
      __$$MouseButtonProtocolDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MouseButton type});
}

/// @nodoc
class __$$MouseButtonProtocolDataImplCopyWithImpl<$Res>
    extends _$MouseButtonProtocolDataCopyWithImpl<$Res,
        _$MouseButtonProtocolDataImpl>
    implements _$$MouseButtonProtocolDataImplCopyWith<$Res> {
  __$$MouseButtonProtocolDataImplCopyWithImpl(
      _$MouseButtonProtocolDataImpl _value,
      $Res Function(_$MouseButtonProtocolDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MouseButtonProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$MouseButtonProtocolDataImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MouseButton,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MouseButtonProtocolDataImpl implements _MouseButtonProtocolData {
  const _$MouseButtonProtocolDataImpl({required this.type});

  factory _$MouseButtonProtocolDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MouseButtonProtocolDataImplFromJson(json);

  @override
  final MouseButton type;

  @override
  String toString() {
    return 'MouseButtonProtocolData(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MouseButtonProtocolDataImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of MouseButtonProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MouseButtonProtocolDataImplCopyWith<_$MouseButtonProtocolDataImpl>
      get copyWith => __$$MouseButtonProtocolDataImplCopyWithImpl<
          _$MouseButtonProtocolDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MouseButtonProtocolDataImplToJson(
      this,
    );
  }
}

abstract class _MouseButtonProtocolData implements MouseButtonProtocolData {
  const factory _MouseButtonProtocolData({required final MouseButton type}) =
      _$MouseButtonProtocolDataImpl;

  factory _MouseButtonProtocolData.fromJson(Map<String, dynamic> json) =
      _$MouseButtonProtocolDataImpl.fromJson;

  @override
  MouseButton get type;

  /// Create a copy of MouseButtonProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MouseButtonProtocolDataImplCopyWith<_$MouseButtonProtocolDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MouseMovementProtocolData _$MouseMovementProtocolDataFromJson(
    Map<String, dynamic> json) {
  return _MouseMovementProtocolData.fromJson(json);
}

/// @nodoc
mixin _$MouseMovementProtocolData {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get intensity => throw _privateConstructorUsedError;

  /// Serializes this MouseMovementProtocolData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MouseMovementProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MouseMovementProtocolDataCopyWith<MouseMovementProtocolData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MouseMovementProtocolDataCopyWith<$Res> {
  factory $MouseMovementProtocolDataCopyWith(MouseMovementProtocolData value,
          $Res Function(MouseMovementProtocolData) then) =
      _$MouseMovementProtocolDataCopyWithImpl<$Res, MouseMovementProtocolData>;
  @useResult
  $Res call({double x, double y, double intensity});
}

/// @nodoc
class _$MouseMovementProtocolDataCopyWithImpl<$Res,
        $Val extends MouseMovementProtocolData>
    implements $MouseMovementProtocolDataCopyWith<$Res> {
  _$MouseMovementProtocolDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MouseMovementProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? intensity = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MouseMovementProtocolDataImplCopyWith<$Res>
    implements $MouseMovementProtocolDataCopyWith<$Res> {
  factory _$$MouseMovementProtocolDataImplCopyWith(
          _$MouseMovementProtocolDataImpl value,
          $Res Function(_$MouseMovementProtocolDataImpl) then) =
      __$$MouseMovementProtocolDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, double intensity});
}

/// @nodoc
class __$$MouseMovementProtocolDataImplCopyWithImpl<$Res>
    extends _$MouseMovementProtocolDataCopyWithImpl<$Res,
        _$MouseMovementProtocolDataImpl>
    implements _$$MouseMovementProtocolDataImplCopyWith<$Res> {
  __$$MouseMovementProtocolDataImplCopyWithImpl(
      _$MouseMovementProtocolDataImpl _value,
      $Res Function(_$MouseMovementProtocolDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MouseMovementProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? intensity = null,
  }) {
    return _then(_$MouseMovementProtocolDataImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MouseMovementProtocolDataImpl implements _MouseMovementProtocolData {
  const _$MouseMovementProtocolDataImpl(
      {required this.x, required this.y, required this.intensity});

  factory _$MouseMovementProtocolDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MouseMovementProtocolDataImplFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double intensity;

  @override
  String toString() {
    return 'MouseMovementProtocolData(x: $x, y: $y, intensity: $intensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MouseMovementProtocolDataImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, intensity);

  /// Create a copy of MouseMovementProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MouseMovementProtocolDataImplCopyWith<_$MouseMovementProtocolDataImpl>
      get copyWith => __$$MouseMovementProtocolDataImplCopyWithImpl<
          _$MouseMovementProtocolDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MouseMovementProtocolDataImplToJson(
      this,
    );
  }
}

abstract class _MouseMovementProtocolData implements MouseMovementProtocolData {
  const factory _MouseMovementProtocolData(
      {required final double x,
      required final double y,
      required final double intensity}) = _$MouseMovementProtocolDataImpl;

  factory _MouseMovementProtocolData.fromJson(Map<String, dynamic> json) =
      _$MouseMovementProtocolDataImpl.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double get intensity;

  /// Create a copy of MouseMovementProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MouseMovementProtocolDataImplCopyWith<_$MouseMovementProtocolDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
