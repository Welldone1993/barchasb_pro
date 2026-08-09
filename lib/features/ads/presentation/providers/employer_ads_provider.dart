import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/ads_remote_data_source.dart';
import '../../data/repositories/ads_repository_impl.dart';
import '../../domain/entities/employer_ad_entity.dart';

class EmployerAdsNotifier
    extends StateNotifier<AsyncValue<List<EmployerAdEntity>>> {
  final AdsRepositoryImpl _repository;

  EmployerAdsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchEmployerAds();
  }

  Future<void> fetchEmployerAds() async {
    state = const AsyncValue.loading();
    final result = await _repository.fetchEmployerAds();
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (ads) {
        state = AsyncValue.data(ads);
      },
    );
  }
}

final employerAdsProvider =
    StateNotifierProvider<
      EmployerAdsNotifier,
      AsyncValue<List<EmployerAdEntity>>
    >((ref) {
      final dio = ref.watch(dioProvider);
      final remote = AdsRemoteDataSourceImpl(dio);
      final repo = AdsRepositoryImpl(remote);
      return EmployerAdsNotifier(repo);
    });
