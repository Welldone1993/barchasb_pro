import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/ad_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeState {
  final AsyncValue<List<AdEntity>> sellers;
  final AsyncValue<List<AdEntity>> employers;
  final AsyncValue<List<AdEntity>> jobSeekers;

  HomeState({
    this.sellers = const AsyncValue.loading(),
    this.employers = const AsyncValue.loading(),
    this.jobSeekers = const AsyncValue.loading(),
  });

  HomeState copyWith({
    AsyncValue<List<AdEntity>>? sellers,
    AsyncValue<List<AdEntity>>? employers,
    AsyncValue<List<AdEntity>>? jobSeekers,
  }) {
    return HomeState(
      sellers: sellers ?? this.sellers,
      employers: employers ?? this.employers,
      jobSeekers: jobSeekers ?? this.jobSeekers,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;
  Timer? _debounceTimer;

  HomeNotifier(this._homeRepository) : super(HomeState()) {
    fetchAll();
  }

  Future<void> fetchAll({String? query}) async {
    await Future.wait([
      fetchSellers(query: query),
      fetchEmployers(query: query),
      fetchJobSeekers(query: query),
    ]);
  }

  Future<void> fetchSellers({String? query}) async {
    state = state.copyWith(sellers: const AsyncValue.loading());
    final result = await _homeRepository.getSellers(query: query);

    result.fold(
      (failure) => state = state.copyWith(
        sellers: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(sellers: AsyncValue.data(data)),
    );
  }

  Future<void> fetchEmployers({String? query}) async {
    state = state.copyWith(employers: const AsyncValue.loading());

    final result = await _homeRepository.getEmployers(query: query);
    result.fold(
      (failure) => state = state.copyWith(
        employers: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(employers: AsyncValue.data(data)),
    );
  }

  Future<void> fetchJobSeekers({String? query}) async {
    state = state.copyWith(jobSeekers: const AsyncValue.loading());
    final result = await _homeRepository.getJobSeekers(query: query);
    result.fold(
      (failure) => state = state.copyWith(
        jobSeekers: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(jobSeekers: AsyncValue.data(data)),
    );
  }

  void searchAds(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final trimmed = query.trim();
      fetchAll(query: trimmed.isNotEmpty ? trimmed : null);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final dio = ref.watch(dioProvider);
  final remote = HomeRemoteDataSourceImpl(dio);
  final repo = HomeRepositoryImpl(remote);
  return HomeNotifier(repo);
});
