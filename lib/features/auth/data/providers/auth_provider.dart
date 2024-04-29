import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repositories/auth_repository.dart';
import '../states/auth_state.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(repo, null);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;
  AuthStateNotifier(this._repo, [AuthState? state])
      : super(state ?? const AuthState()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      final String? token = _repo.getToken();
      if (token != null) {
        state = state.copyWith(
          isLogin: true,
        );
      } else {
        state = state.copyWith();
      }
    } catch (_) {}
  }

  bool isUserLoggedIn() {
    return state.isLogin != null;
  }

  setAppLang(appLang) {
    state = state.copyWith(appLang: appLang);
  }
  anonymousLogin() async {
    try {
      state = state.copyWith(loading: true);

      final result = await _repo.anonymousLogin();
      state = state.copyWith(loading: false,isLogin: true,token: getToken(),errorMessage: '');

      return result;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), loading: false);
      return false;
    }
  }

  getToken() {
    return _repo.getToken();
  }

  Future<void> logout() async {

    _repo.logout();
    _repo.deleteTokenCachedData();
    state = state.copyWith(
      isLogin: false,
      token: null,
      loading: false,
    );
  }
}
