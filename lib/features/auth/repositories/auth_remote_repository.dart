import "dart:convert";
import "package:client/core/constants/server_constant.dart";
import "package:http/http.dart" as http;

class AuthRemoteRepository {
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse('${ServerConstant.serverURL}/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
    print(res.body);
    print(res.statusCode);
  }

  Future<void> login({required String email, required String password}) async {
    final res = await http.post(
      Uri.parse('${ServerConstant.serverURL}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );
    print(res.body);
    print(res.statusCode);
  }
}
