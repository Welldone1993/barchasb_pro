import 'package:barchasb/core/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/create_job_seeker_ad_entity.dart';
import '../../domain/repositories/create_job_seeker_ad_repository.dart';
import '../datasources/create_job_seeker_ad_remote_data_source.dart';
import '../dtos/create_job_seeker_ad_dto.dart';

class CreateJobSeekerAdRepositoryImpl extends CreateJobSeekerAdRepository {
  final CreateJobSeekerAdRemoteDataSource _remote;

  CreateJobSeekerAdRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, CreateJobSeekerAdEntity>> createJobSeekerAd(
    CreateJobSeekerAdRequestDto employerAd,
  ) async {
    try {
      final dynamic result = await _remote.createJobSeekerAd(employerAd);

      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
