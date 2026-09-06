import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/ad_detail_remote_data_source.dart';
import '../../data/repositories/ad_detail_repository_impl.dart';
import '../../domain/entities/job_seeker_ad_detail_entity.dart';
import '../../domain/repositories/ads_detail_repository.dart';

// 1. Data Source Provider
final jobSeekerAdRemoteDataSourceProvider = Provider<AdDetailRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AdDetailRemoteDataSourceImpl(dio);
});

// 2. Repository Provider
final jobSeekerAdDetailRepositoryProvider = Provider<AdDetailRepository>((ref) {
  final dataSource = ref.watch(jobSeekerAdRemoteDataSourceProvider);
  return AdDetailRepositoryImpl(dataSource);
});

// 3. Family FutureProvider برای دریافت بر اساس id
final jobSeekerAdDetailProvider =
FutureProvider.family.autoDispose<JobSeekerAdDetailEntity, String>((ref, id) async {
  final repository = ref.watch(jobSeekerAdDetailRepositoryProvider);
  final result = await repository.getJobSeekerAdById(id);

  return result.fold(
        (failure) => throw Exception(failure),
        (adDetail) => adDetail,
  );
});
