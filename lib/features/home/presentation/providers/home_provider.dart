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

  Future<void> fetchAll() async {
    await Future.wait([fetchSellers(), fetchEmployers(), fetchJobSeekers()]);
  }

  Future<void> fetchSellers() async {
    state = state.copyWith(sellers: const AsyncValue.loading());
    final result = await _homeRepository.getSellers();

    result.fold(
      (failure) => state = state.copyWith(
        sellers: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(sellers: AsyncValue.data(data)),
    );
  }

  Future<void> fetchEmployers() async {
    state = state.copyWith(employers: const AsyncValue.loading());

    final result = await _homeRepository.getEmployers();
    result.fold(
      (failure) => state = state.copyWith(
        employers: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(employers: AsyncValue.data(data)),
    );
  }

  Future<void> fetchJobSeekers() async {
    state = state.copyWith(jobSeekers: const AsyncValue.loading());
    final result = await _homeRepository.getJobSeekers();
    result.fold(
      (failure) => state = state.copyWith(
        jobSeekers: AsyncValue.error(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(jobSeekers: AsyncValue.data(data)),
    );
  }

  void searchAds(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    if (query.isEmpty) {
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      fetchAll();
    });
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final dio = ref.watch(dioProvider);
  final remote = HomeRemoteDataSourceImpl(dio);
  final repo = HomeRepositoryImpl(remote);
  return HomeNotifier(repo);
});
