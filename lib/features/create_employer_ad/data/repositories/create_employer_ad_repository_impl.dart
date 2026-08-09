import 'package:barchasb/core/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/create_employer_ad_entity.dart';
import '../../domain/repositories/create_employer_ad_repository.dart';
import '../datasources/create_employer_ad_remote_data_source.dart';
import '../dtos/create_employer_ad_dto.dart';

class CreateEmployerAdRepositoryImpl extends CreateEmployerAdRepository {
  final CreateEmployerAdRemoteDataSource _remote;

  CreateEmployerAdRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, CreateEmployerAdEntity>> createEmployerAd(
    CreateEmployerAdRequestDto employerAd,
  ) async {
    try {
      final dynamic result = await _remote.createEmployerAd(employerAd);

      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
