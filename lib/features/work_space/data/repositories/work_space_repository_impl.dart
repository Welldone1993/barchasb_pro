import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/entities/ad_entity.dart';
import '../../domain/entities/weekly_stats_entity.dart';
import '../../domain/repositories/work_space_repository.dart';
import '../datasource/work_space_remote_data_source.dart';

class WorkSpaceRepositoryImpl implements WorkSpaceRepository {
  final WorkSpaceRemoteDataSource _remoteDataSource;

  WorkSpaceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<AdEntity>>> fetchAds() async {
    try {
      final List<AdEntity> ads = await _remoteDataSource.fetchAds();
      return Right(ads);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }

  @override
  Future<Either<Failure, List<WeeklyStatsEntity>>> fetchWeeklyStats() async {
    try {
      final List<WeeklyStatsEntity> weeklyStats = await _remoteDataSource
          .fetchWeeklyStats();
      return Right(weeklyStats);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
