import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../data/dtos/create_job_seeker_ad_dto.dart';
import '../entities/create_job_seeker_ad_entity.dart';

abstract class CreateJobSeekerAdRepository {
  Future<Either<Failure, CreateJobSeekerAdEntity>> createJobSeekerAd(
    CreateJobSeekerAdRequestDto jobSeekerAd,
  );
}
