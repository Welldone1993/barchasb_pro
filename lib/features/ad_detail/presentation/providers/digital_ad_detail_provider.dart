// 1. Data Source Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/ad_detail_remote_data_source.dart';
import '../../data/repositories/ad_detail_repository_impl.dart';
import '../../domain/entities/digital_ad_detail_entity.dart';
import '../../domain/repositories/ads_detail_repository.dart';

final digitalAdRemoteDataSourceProvider = Provider<AdDetailRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return AdDetailRemoteDataSourceImpl(dio);
});

// 2. Repository Provider
final digitalAdDetailRepositoryProvider = Provider<AdDetailRepository>((ref) {
  final dataSource = ref.watch(digitalAdRemoteDataSourceProvider);
  return AdDetailRepositoryImpl(dataSource);
});

// 3. Family FutureProvider برای دریافت بر اساس id
final digitalAdDetailProvider = FutureProvider.family
    .autoDispose<DigitalAdDetailEntity, String>((ref, id) async {
      final repository = ref.watch(digitalAdDetailRepositoryProvider);
      final result = await repository.getDigitalAdById(id);

      return result.fold(
        (failure) => throw Exception(failure),
        (adDetail) => adDetail,
      );
    });
