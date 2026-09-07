import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/repositories/create_digital_ad_repository.dart';
import '../datasources/create_digital_ad_remote_data_source.dart';
import '../dtos/create_digital_ad_request_dto.dart';

class CreateDigitalAdRepositoryImpl extends CreateDigitalAdRepository {
  final CreateDigitalAdRemoteDataSource _remote;

  CreateDigitalAdRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, dynamic>> createDigitalAd(
    CreateDigitalAdRequestDto digitalAd,
  ) async {
    try {
      final dynamic result = await _remote.createDigitalAd(digitalAd);

      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> sendOtp(String phone) async {
    try {
      final dynamic result = await _remote.sendOtp(phone);

      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
