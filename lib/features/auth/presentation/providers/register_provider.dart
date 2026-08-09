import 'package:barchasb/features/auth/domain/entities/province_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/network/dio_provider.dart';
import '../../../../core/widgets/comming_soon_snack_bar.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/user_entity.dart';

class RegisterState {
  final bool isLoading;
  final LoginEntity? user;
  final UserEntity? registeredUser;
  final String? error;
  final List<ProvinceEntity> provinces;

  RegisterState({
    this.isLoading = false,
    this.user,
    this.registeredUser,
    this.error,
    this.provinces = const [],
  });

  RegisterState copyWith({
    bool? isLoading,
    LoginEntity? user,
    UserEntity? registeredUser,
    String? error,
    bool clearError = false,
    List<ProvinceEntity>? provinces,
  }) => RegisterState(
    isLoading: isLoading ?? this.isLoading,
    user: user ?? this.user,
    registeredUser: registeredUser ?? this.registeredUser,
    error: clearError ? null : (error ?? this.error),
    provinces: provinces ?? this.provinces,
  );
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthRepositoryImpl _repository;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  RegisterNotifier(this._repository) : super(RegisterState()) {
    getProvinces();
  }

  Future<void> register(BuildContext context,RegisterEntity data) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.register(data);

    result.fold(
      (failure) {
          state = state.copyWith(isLoading: false, error: failure.toString());
          CustomSnackBar(
            title: failure.message,
          ).show(context);
    },
      (user) {
        state = state.copyWith(isLoading: false);
        context.go('/login');
      },
    );
  }

  Future<void> getProvinces() async {
    final result = await _repository.getProvinces();
    result.fold((l) {}, (result) {
      state = state.copyWith(provinces: result);
    });
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final remote = AuthRemoteDataSourceImpl(dio);
    final repo = AuthRepositoryImpl(remote);
    return RegisterNotifier(repo);
  },
);
