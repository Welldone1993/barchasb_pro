import 'package:barchasb/core/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/create_seller_ad_entity.dart';
import '../../domain/repositories/create_seller_ad_repository.dart';
import '../datasources/create_seller_ad_remote_data_source.dart';
import '../dtos/create_seller_ad_dto.dart';

class CreateSellerAdRepositoryImpl extends CreateSellerAdRepository {
  final CreateSellerAdRemoteDataSource _remote;

  CreateSellerAdRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, CreateSellerAdEntity>> createSellerAd(
    CreateSellerAdDto employerAd,
  ) async {
    try {
      final dynamic result = await _remote.createSellerAd(employerAd);

      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
