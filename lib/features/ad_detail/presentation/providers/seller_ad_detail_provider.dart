// 1. Data Source Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/ad_detail_remote_data_source.dart';
import '../../data/repositories/ad_detail_repository_impl.dart';
import '../../domain/entities/seller_ad_detail_entity.dart';
import '../../domain/repositories/ads_detail_repository.dart';

final sellerAdRemoteDataSourceProvider = Provider<AdDetailRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return AdDetailRemoteDataSourceImpl(dio);
});

// 2. Repository Provider
final sellerAdDetailRepositoryProvider = Provider<AdDetailRepository>((ref) {
  final dataSource = ref.watch(sellerAdRemoteDataSourceProvider);
  return AdDetailRepositoryImpl(dataSource);
});

// 3. Family FutureProvider برای دریافت بر اساس id
final sellerAdDetailProvider = FutureProvider.family
    .autoDispose<SellerAdDetailEntity, String>((ref, id) async {
      final repository = ref.watch(sellerAdDetailRepositoryProvider);
      final result = await repository.getSellerAdById(id);

      return result.fold(
        (failure) => throw Exception(failure),
        (adDetail) => adDetail,
      );
    });
