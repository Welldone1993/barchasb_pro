import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/network/dio_provider.dart';
import '../../../../core/widgets/comming_soon_snack_bar.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/user_entity.dart';

class AuthState {
  final bool isLoading;
  final LoginEntity? user;
  final UserEntity? registeredUser;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.user,
    this.registeredUser,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    LoginEntity? user,
    UserEntity? registeredUser,
    String? error,
    bool clearError = false,
  }) => AuthState(
    isLoading: isLoading ?? this.isLoading,
    user: user ?? this.user,
    registeredUser: registeredUser ?? this.registeredUser,
    error: clearError ? null : (error ?? this.error),
  );
}

class LoginNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryImpl _repository;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  LoginNotifier(this._repository) : super(AuthState());

  Future<void> login(
    BuildContext context,
    String phone,
    String password,
  ) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final user = await _repository.login(phone, password);

    user.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.toString());
        if (context.mounted) {
          CustomSnackBar(
            title: 'شماره تلفن یا رمز عبور اشتباه است',
          ).show(context);
        }
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
        storage.write(key: 'auth_token', value: user.token);
        state = state.copyWith(isLoading: false, user: user);
        if (context.mounted) {
          context.pushReplacement('/dashboard');
        }
      },
    );
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, AuthState>((ref) {
  final dio = ref.watch(dioProvider);
  final remote = AuthRemoteDataSourceImpl(dio);
  final repo = AuthRepositoryImpl(remote);
  return LoginNotifier(repo);
});
