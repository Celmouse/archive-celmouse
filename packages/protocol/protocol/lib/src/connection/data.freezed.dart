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

ConnectionInfoProtocolData _$ConnectionInfoProtocolDataFromJson(
    Map<String, dynamic> json) {
  return _ConnectionInfoProtocolData.fromJson(json);
}

/// @nodoc
mixin _$ConnectionInfoProtocolData {
  String get deviceName => throw _privateConstructorUsedError;
  DeviceOS get deviceOS => throw _privateConstructorUsedError;
  String get versionNumber => throw _privateConstructorUsedError;

  /// Serializes this ConnectionInfoProtocolData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionInfoProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionInfoProtocolDataCopyWith<ConnectionInfoProtocolData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionInfoProtocolDataCopyWith<$Res> {
  factory $ConnectionInfoProtocolDataCopyWith(ConnectionInfoProtocolData value,
          $Res Function(ConnectionInfoProtocolData) then) =
      _$ConnectionInfoProtocolDataCopyWithImpl<$Res,
          ConnectionInfoProtocolData>;
  @useResult
  $Res call({String deviceName, DeviceOS deviceOS, String versionNumber});
}

/// @nodoc
class _$ConnectionInfoProtocolDataCopyWithImpl<$Res,
        $Val extends ConnectionInfoProtocolData>
    implements $ConnectionInfoProtocolDataCopyWith<$Res> {
  _$ConnectionInfoProtocolDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionInfoProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceName = null,
    Object? deviceOS = null,
    Object? versionNumber = null,
  }) {
    return _then(_value.copyWith(
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceOS: null == deviceOS
          ? _value.deviceOS
          : deviceOS // ignore: cast_nullable_to_non_nullable
              as DeviceOS,
      versionNumber: null == versionNumber
          ? _value.versionNumber
          : versionNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionInfoProtocolDataImplCopyWith<$Res>
    implements $ConnectionInfoProtocolDataCopyWith<$Res> {
  factory _$$ConnectionInfoProtocolDataImplCopyWith(
          _$ConnectionInfoProtocolDataImpl value,
          $Res Function(_$ConnectionInfoProtocolDataImpl) then) =
      __$$ConnectionInfoProtocolDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String deviceName, DeviceOS deviceOS, String versionNumber});
}

/// @nodoc
class __$$ConnectionInfoProtocolDataImplCopyWithImpl<$Res>
    extends _$ConnectionInfoProtocolDataCopyWithImpl<$Res,
        _$ConnectionInfoProtocolDataImpl>
    implements _$$ConnectionInfoProtocolDataImplCopyWith<$Res> {
  __$$ConnectionInfoProtocolDataImplCopyWithImpl(
      _$ConnectionInfoProtocolDataImpl _value,
      $Res Function(_$ConnectionInfoProtocolDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionInfoProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceName = null,
    Object? deviceOS = null,
    Object? versionNumber = null,
  }) {
    return _then(_$ConnectionInfoProtocolDataImpl(
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceOS: null == deviceOS
          ? _value.deviceOS
          : deviceOS // ignore: cast_nullable_to_non_nullable
              as DeviceOS,
      versionNumber: null == versionNumber
          ? _value.versionNumber
          : versionNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionInfoProtocolDataImpl implements _ConnectionInfoProtocolData {
  const _$ConnectionInfoProtocolDataImpl(
      {required this.deviceName,
      required this.deviceOS,
      required this.versionNumber});

  factory _$ConnectionInfoProtocolDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ConnectionInfoProtocolDataImplFromJson(json);

  @override
  final String deviceName;
  @override
  final DeviceOS deviceOS;
  @override
  final String versionNumber;

  @override
  String toString() {
    return 'ConnectionInfoProtocolData(deviceName: $deviceName, deviceOS: $deviceOS, versionNumber: $versionNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionInfoProtocolDataImpl &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceOS, deviceOS) ||
                other.deviceOS == deviceOS) &&
            (identical(other.versionNumber, versionNumber) ||
                other.versionNumber == versionNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, deviceName, deviceOS, versionNumber);

  /// Create a copy of ConnectionInfoProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionInfoProtocolDataImplCopyWith<_$ConnectionInfoProtocolDataImpl>
      get copyWith => __$$ConnectionInfoProtocolDataImplCopyWithImpl<
          _$ConnectionInfoProtocolDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionInfoProtocolDataImplToJson(
      this,
    );
  }
}

abstract class _ConnectionInfoProtocolData
    implements ConnectionInfoProtocolData {
  const factory _ConnectionInfoProtocolData(
      {required final String deviceName,
      required final DeviceOS deviceOS,
      required final String versionNumber}) = _$ConnectionInfoProtocolDataImpl;

  factory _ConnectionInfoProtocolData.fromJson(Map<String, dynamic> json) =
      _$ConnectionInfoProtocolDataImpl.fromJson;

  @override
  String get deviceName;
  @override
  DeviceOS get deviceOS;
  @override
  String get versionNumber;

  /// Create a copy of ConnectionInfoProtocolData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionInfoProtocolDataImplCopyWith<_$ConnectionInfoProtocolDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DesktopToMobileData _$DesktopToMobileDataFromJson(Map<String, dynamic> json) {
  return _DesktopToMobileData.fromJson(json);
}

/// @nodoc
mixin _$DesktopToMobileData {
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this DesktopToMobileData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DesktopToMobileData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DesktopToMobileDataCopyWith<DesktopToMobileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesktopToMobileDataCopyWith<$Res> {
  factory $DesktopToMobileDataCopyWith(
          DesktopToMobileData value, $Res Function(DesktopToMobileData) then) =
      _$DesktopToMobileDataCopyWithImpl<$Res, DesktopToMobileData>;
  @useResult
  $Res call({String message, DateTime timestamp});
}

/// @nodoc
class _$DesktopToMobileDataCopyWithImpl<$Res, $Val extends DesktopToMobileData>
    implements $DesktopToMobileDataCopyWith<$Res> {
  _$DesktopToMobileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DesktopToMobileData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DesktopToMobileDataImplCopyWith<$Res>
    implements $DesktopToMobileDataCopyWith<$Res> {
  factory _$$DesktopToMobileDataImplCopyWith(_$DesktopToMobileDataImpl value,
          $Res Function(_$DesktopToMobileDataImpl) then) =
      __$$DesktopToMobileDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, DateTime timestamp});
}

/// @nodoc
class __$$DesktopToMobileDataImplCopyWithImpl<$Res>
    extends _$DesktopToMobileDataCopyWithImpl<$Res, _$DesktopToMobileDataImpl>
    implements _$$DesktopToMobileDataImplCopyWith<$Res> {
  __$$DesktopToMobileDataImplCopyWithImpl(_$DesktopToMobileDataImpl _value,
      $Res Function(_$DesktopToMobileDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DesktopToMobileData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_$DesktopToMobileDataImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DesktopToMobileDataImpl implements _DesktopToMobileData {
  const _$DesktopToMobileDataImpl(
      {required this.message, required this.timestamp});

  factory _$DesktopToMobileDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DesktopToMobileDataImplFromJson(json);

  @override
  final String message;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'DesktopToMobileData(message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesktopToMobileDataImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, timestamp);

  /// Create a copy of DesktopToMobileData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DesktopToMobileDataImplCopyWith<_$DesktopToMobileDataImpl> get copyWith =>
      __$$DesktopToMobileDataImplCopyWithImpl<_$DesktopToMobileDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DesktopToMobileDataImplToJson(
      this,
    );
  }
}

abstract class _DesktopToMobileData implements DesktopToMobileData {
  const factory _DesktopToMobileData(
      {required final String message,
      required final DateTime timestamp}) = _$DesktopToMobileDataImpl;

  factory _DesktopToMobileData.fromJson(Map<String, dynamic> json) =
      _$DesktopToMobileDataImpl.fromJson;

  @override
  String get message;
  @override
  DateTime get timestamp;

  /// Create a copy of DesktopToMobileData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesktopToMobileDataImplCopyWith<_$DesktopToMobileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MobileToDesktopData _$MobileToDesktopDataFromJson(Map<String, dynamic> json) {
  return _MobileToDesktopData.fromJson(json);
}

/// @nodoc
mixin _$MobileToDesktopData {
  String get message => throw _privateConstructorUsedError;

  /// Serializes this MobileToDesktopData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MobileToDesktopData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MobileToDesktopDataCopyWith<MobileToDesktopData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobileToDesktopDataCopyWith<$Res> {
  factory $MobileToDesktopDataCopyWith(
          MobileToDesktopData value, $Res Function(MobileToDesktopData) then) =
      _$MobileToDesktopDataCopyWithImpl<$Res, MobileToDesktopData>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$MobileToDesktopDataCopyWithImpl<$Res, $Val extends MobileToDesktopData>
    implements $MobileToDesktopDataCopyWith<$Res> {
  _$MobileToDesktopDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MobileToDesktopData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MobileToDesktopDataImplCopyWith<$Res>
    implements $MobileToDesktopDataCopyWith<$Res> {
  factory _$$MobileToDesktopDataImplCopyWith(_$MobileToDesktopDataImpl value,
          $Res Function(_$MobileToDesktopDataImpl) then) =
      __$$MobileToDesktopDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MobileToDesktopDataImplCopyWithImpl<$Res>
    extends _$MobileToDesktopDataCopyWithImpl<$Res, _$MobileToDesktopDataImpl>
    implements _$$MobileToDesktopDataImplCopyWith<$Res> {
  __$$MobileToDesktopDataImplCopyWithImpl(_$MobileToDesktopDataImpl _value,
      $Res Function(_$MobileToDesktopDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MobileToDesktopData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MobileToDesktopDataImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MobileToDesktopDataImpl implements _MobileToDesktopData {
  const _$MobileToDesktopDataImpl({required this.message});

  factory _$MobileToDesktopDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MobileToDesktopDataImplFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'MobileToDesktopData(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobileToDesktopDataImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MobileToDesktopData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MobileToDesktopDataImplCopyWith<_$MobileToDesktopDataImpl> get copyWith =>
      __$$MobileToDesktopDataImplCopyWithImpl<_$MobileToDesktopDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MobileToDesktopDataImplToJson(
      this,
    );
  }
}

abstract class _MobileToDesktopData implements MobileToDesktopData {
  const factory _MobileToDesktopData({required final String message}) =
      _$MobileToDesktopDataImpl;

  factory _MobileToDesktopData.fromJson(Map<String, dynamic> json) =
      _$MobileToDesktopDataImpl.fromJson;

  @override
  String get message;

  /// Create a copy of MobileToDesktopData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MobileToDesktopDataImplCopyWith<_$MobileToDesktopDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
