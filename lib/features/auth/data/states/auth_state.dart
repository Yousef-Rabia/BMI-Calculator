import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default("") String? token,
    @Default("en") String? appLang,
    @Default(false) bool? isLogin,
    @Default(false) bool loading,
    @Default(null) String? errorMessage,
  }) = _AuthState;
}
