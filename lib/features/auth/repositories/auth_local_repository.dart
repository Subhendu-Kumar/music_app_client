import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setAccessToken(String? accessToken) {
    if (accessToken != null) {
      _sharedPreferences.setString("x-auth-token", accessToken);
    }
  }

  String? getAccessToken() {
    return _sharedPreferences.getString("x-auth-token");
  }
}
