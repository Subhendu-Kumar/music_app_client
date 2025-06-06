import "dart:convert";
import "package:fpdart/fpdart.dart";
import "package:http/http.dart" as http;
import "package:client/core/failure/failure.dart";
import "package:client/core/constants/server_constant.dart";
import "package:client/features/auth/model/user_model.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstant.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 201) {
        return left(
          AppFailure(
            "Failed to sign up: ${res.statusCode} - ${resBodyMap["detail"] ?? "Unknown error"}",
          ),
        );
      }
      return right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return left(
        AppFailure("An error occurred while signing up: ${e.toString()}"),
      );
    }
  }

  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstant.serverURL}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return left(
          AppFailure(
            "Failed to sign in: ${res.statusCode} - ${resBodyMap["detail"] ?? "Unknown error"}",
          ),
        );
      }
      return right(
        UserModel.fromMap(
          resBodyMap["user"],
        ).copyWith(accessToken: resBodyMap["accessToken"]),
      );
    } catch (e) {
      return left(
        AppFailure("An error occurred while signing in: ${e.toString()}"),
      );
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData(String token) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstant.serverURL}/auth/user'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return left(
          AppFailure(
            "Failed to sign in: ${res.statusCode} - ${resBodyMap["detail"] ?? "Unknown error"}",
          ),
        );
      }
      return right(UserModel.fromMap(resBodyMap).copyWith(accessToken: token));
    } catch (e) {
      return left(
        AppFailure("An error occurred while signing in: ${e.toString()}"),
      );
    }
  }
}
