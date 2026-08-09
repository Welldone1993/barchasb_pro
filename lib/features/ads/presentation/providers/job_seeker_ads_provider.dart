import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/ads_remote_data_source.dart';
import '../../data/repositories/ads_repository_impl.dart';
import '../../domain/entities/job_seeker_ad_entity.dart';

class JobSeekerAdsNotifier
    extends StateNotifier<AsyncValue<List<JobSeekerAdEntity>>> {
  final AdsRepositoryImpl _repository;

  JobSeekerAdsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchJobSeekerAds();
  }

  Future<void> fetchJobSeekerAds() async {
    state = const AsyncValue.loading();
    final result = await _repository.fetchJobSeekerAds();
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (ads) {
        state = AsyncValue.data(ads);
      },
    );
  }
}

final jobSeekerAdsProvider =
    StateNotifierProvider<
      JobSeekerAdsNotifier,
      AsyncValue<List<JobSeekerAdEntity>>
    >((ref) {
      final dio = ref.watch(dioProvider);
      final remote = AdsRemoteDataSourceImpl(dio);
      final repo = AdsRepositoryImpl(remote);
      return JobSeekerAdsNotifier(repo);
    });
