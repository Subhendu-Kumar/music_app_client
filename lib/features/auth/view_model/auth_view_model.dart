import 'package:client/core/failure/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;
  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );
    final val = switch (res) {
      Left(value: final l) =>
        state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );
    final val = switch (res) {
      Left(value: final l) =>
        state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _loginSuccess(r),
    };
    print(val);
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocalRepository.setAccessToken(user.accessToken);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getCurrentUser() async {
    state = const AsyncValue.loading();
    final accessToken = _authLocalRepository.getAccessToken();
    if (accessToken != null) {
      final res = await _authRemoteRepository.getCurrentUserData(accessToken);
      final val = switch (res) {
        Left(value: final l) => _getCurrentUserFailure(l.message, l),
        Right(value: final r) => _getCurrentUserSuccess(r),
      };
      print(val);
      return val.value;
    }
    return null;
  }

  AsyncValue<UserModel> _getCurrentUserFailure(
    String message,
    AppFailure failure,
  ) {
    if (message.contains('401') ||
        message.toLowerCase().contains('unauthorized') ||
        message.toLowerCase().contains('token')) {
      _authLocalRepository.clearAccessToken();
      _currentUserNotifier.addUser(null);
    }
    _currentUserNotifier.addUser(null);
    return state = AsyncValue.error(message, StackTrace.current);
  }

  AsyncValue<UserModel> _getCurrentUserSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}
