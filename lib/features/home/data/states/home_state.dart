import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(null) String? errorMessage,
    @Default(false) bool homeLoading,
    @Default(null) String? BMI,
    @Default(1) int screenIndex,
  }) = _HomeState;
}
