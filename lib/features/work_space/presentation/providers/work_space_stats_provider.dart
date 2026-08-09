import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/work_space_remote_data_source.dart';
import '../../data/repositories/work_space_repository_impl.dart';
import '../../domain/entities/weekly_stats_entity.dart';

class WorkspaceStatsState {
  final AsyncValue<List<WeeklyStatsEntity>> weeklyStats;

  WorkspaceStatsState({this.weeklyStats = const AsyncValue.loading()});

  WorkspaceStatsState copyWith({
    AsyncValue<List<WeeklyStatsEntity>>? weeklyStats,
  }) {
    return WorkspaceStatsState(weeklyStats: weeklyStats ?? this.weeklyStats);
  }
}

class WorkSpaceStatsNotifier extends StateNotifier<WorkspaceStatsState> {
  final WorkSpaceRepositoryImpl _repository;

  WorkSpaceStatsNotifier(this._repository) : super(WorkspaceStatsState()) {
    fetchStats();
  }

  Future<void> fetchStats() async {
    state = state.copyWith(weeklyStats: AsyncValue.loading());
    final result = await _repository.fetchWeeklyStats();
    result.fold(
      (failure) => state = state.copyWith(
        weeklyStats: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (weeklyStats) {
        state = state.copyWith(weeklyStats: AsyncValue.data(weeklyStats));
      },
    );
  }
}

final workSpaceStatsProvider =
    StateNotifierProvider<WorkSpaceStatsNotifier, WorkspaceStatsState>((ref) {
      final dio = ref.watch(dioProvider);
      final remote = WorkSpaceRemoteDataSourceImpl(dio);
      final repo = WorkSpaceRepositoryImpl(remote);
      return WorkSpaceStatsNotifier(repo);
    });
