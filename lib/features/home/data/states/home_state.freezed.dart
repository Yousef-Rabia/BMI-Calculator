// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get homeLoading => throw _privateConstructorUsedError;
  String? get BMI => throw _privateConstructorUsedError;
  int get screenIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {String? errorMessage, bool homeLoading, String? BMI, int screenIndex});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? homeLoading = null,
    Object? BMI = freezed,
    Object? screenIndex = null,
  }) {
    return _then(_value.copyWith(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      homeLoading: null == homeLoading
          ? _value.homeLoading
          : homeLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      BMI: freezed == BMI
          ? _value.BMI
          : BMI // ignore: cast_nullable_to_non_nullable
              as String?,
      screenIndex: null == screenIndex
          ? _value.screenIndex
          : screenIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? errorMessage, bool homeLoading, String? BMI, int screenIndex});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? homeLoading = null,
    Object? BMI = freezed,
    Object? screenIndex = null,
  }) {
    return _then(_$HomeStateImpl(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      homeLoading: null == homeLoading
          ? _value.homeLoading
          : homeLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      BMI: freezed == BMI
          ? _value.BMI
          : BMI // ignore: cast_nullable_to_non_nullable
              as String?,
      screenIndex: null == screenIndex
          ? _value.screenIndex
          : screenIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {this.errorMessage = null,
      this.homeLoading = false,
      this.BMI = null,
      this.screenIndex = 1});

  @override
  @JsonKey()
  final String? errorMessage;
  @override
  @JsonKey()
  final bool homeLoading;
  @override
  @JsonKey()
  final String? BMI;
  @override
  @JsonKey()
  final int screenIndex;

  @override
  String toString() {
    return 'HomeState(errorMessage: $errorMessage, homeLoading: $homeLoading, BMI: $BMI, screenIndex: $screenIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.homeLoading, homeLoading) ||
                other.homeLoading == homeLoading) &&
            (identical(other.BMI, BMI) || other.BMI == BMI) &&
            (identical(other.screenIndex, screenIndex) ||
                other.screenIndex == screenIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, errorMessage, homeLoading, BMI, screenIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final String? errorMessage,
      final bool homeLoading,
      final String? BMI,
      final int screenIndex}) = _$HomeStateImpl;

  @override
  String? get errorMessage;
  @override
  bool get homeLoading;
  @override
  String? get BMI;
  @override
  int get screenIndex;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
