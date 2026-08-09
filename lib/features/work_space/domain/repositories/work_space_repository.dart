import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../entities/ad_entity.dart';
import '../entities/weekly_stats_entity.dart';

abstract class WorkSpaceRepository {
  Future<Either<Failure, List<AdEntity>>> fetchAds();

  Future<Either<Failure, List<WeeklyStatsEntity>>> fetchWeeklyStats();
}
