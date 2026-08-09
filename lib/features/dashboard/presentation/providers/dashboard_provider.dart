import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/user_entity.dart';

class DashboardNotifier extends StateNotifier<AsyncValue<UserEntity>> {
  final DashboardRepositoryImpl _repository;

  DashboardNotifier(this._repository) : super(AsyncValue.loading()) {
    fetchUser();
  }

  final selectedDashboardSectionProvider = StateProvider<int>((ref) => 0);

  Future<void> fetchUser() async {
    state = const AsyncValue.loading();
    final result = await _repository.fetchUser();

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) {
        state = AsyncValue.data(user);
      },
    );
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, AsyncValue<UserEntity>>((ref) {
      final dio = ref.watch(dioProvider);
      final remote = DashboardRemoteDataSourceImpl(dio);
      final repo = DashboardRepositoryImpl(remote);
      return DashboardNotifier(repo);
    });
