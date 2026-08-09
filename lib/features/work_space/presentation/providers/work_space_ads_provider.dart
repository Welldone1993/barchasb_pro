import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/work_space_remote_data_source.dart';
import '../../data/repositories/work_space_repository_impl.dart';
import '../../domain/entities/ad_entity.dart';

class WorkSpaceAdsNotifier extends StateNotifier<AsyncValue<List<AdEntity>>> {
  final WorkSpaceRepositoryImpl _repository;

  WorkSpaceAdsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchAds();
  }

  Future<void> fetchAds() async {
    state = const AsyncValue.loading();
    final result = await _repository.fetchAds();
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (ads) {
        state = AsyncValue.data(ads);
      },
    );
  }

  Future<void> refresh() async {
    await fetchAds();
  }
}

final workSpaceAdsProvider =
    StateNotifierProvider<WorkSpaceAdsNotifier, AsyncValue<List<AdEntity>>>((
      ref,
    ) {
      final dio = ref.watch(dioProvider);
      final remote = WorkSpaceRemoteDataSourceImpl(dio);
      final repo = WorkSpaceRepositoryImpl(remote);
      return WorkSpaceAdsNotifier(repo);
    });
