import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/ads_remote_data_source.dart';
import '../../data/repositories/ads_repository_impl.dart';
import '../../domain/entities/seller_ad_entity.dart';

class SellerAdsNotifier
    extends StateNotifier<AsyncValue<List<SellerAdEntity>>> {
  final AdsRepositoryImpl _repository;

  SellerAdsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchSellerAds();
  }

  Future<void> fetchSellerAds() async {
    state = const AsyncValue.loading();
    final result = await _repository.fetchSellerAds();
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (ads) {
        state = AsyncValue.data(ads);
      },
    );
  }
}

final sellerAdsProvider =
    StateNotifierProvider<
      SellerAdsNotifier,
      AsyncValue<List<SellerAdEntity>>
    >((ref) {
      final dio = ref.watch(dioProvider);
      final remote = AdsRemoteDataSourceImpl(dio);
      final repo = AdsRepositoryImpl(remote);
      return SellerAdsNotifier(repo);
    });
