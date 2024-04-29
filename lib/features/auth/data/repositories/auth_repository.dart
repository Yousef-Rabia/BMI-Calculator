import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/hive_manager.dart';

abstract class AuthRepository {
  Future<bool> anonymousLogin();
  void deleteTokenCachedData();
  String? getToken();

  void logout();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> anonymousLogin() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      var response = await auth.signInAnonymously();
      if (response.user != null) {
        _saveUserLoginResponse(response.user!.uid);
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
  @override
  void deleteTokenCachedData() {
    HiveManager.remove(StorageKeys.tokenKey);
  }
  @override
  String? getToken() {
    final tokenData = HiveManager.getData(StorageKeys.tokenKey);
    return tokenData;
  }

  void _saveUserLoginResponse(String token) {
    HiveManager.addData(StorageKeys.tokenKey, token);
  }

  @override
  void logout() {
    FirebaseAuth.instance.signOut();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
