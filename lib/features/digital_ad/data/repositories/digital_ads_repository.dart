import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/entities/digital_ad_entity.dart';
import '../../domain/repositories/digital_ads_repository.dart';
import '../datasource/digital_ads_remote_data_source.dart';

class DigitalAdsRepositoryImpl extends DigitalAdsRepository {
  final DigitalAdsRemoteDataSource _remoteDatasource;

  DigitalAdsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<CreateDigitalAdEntity>>> fetchDigitalAds({
    required String search,
  }) async {
    try {
      final List<CreateDigitalAdEntity> ads = await _remoteDatasource.fetchDigitalAds(
        search: search,
      );
      return Right(ads);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
