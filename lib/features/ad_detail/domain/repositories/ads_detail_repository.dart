import 'package:fpdart/fpdart.dart';

import '../entities/job_seeker_ad_detail_entity.dart';

abstract class AdDetailRepository {
  Future<Either<String, JobSeekerAdDetailEntity>> getJobSeekerAdById(String id);
}