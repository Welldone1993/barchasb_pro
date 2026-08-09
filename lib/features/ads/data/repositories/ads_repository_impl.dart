import 'package:barchasb/features/ads/domain/entities/employer_ad_entity.dart';
import 'package:barchasb/features/ads/domain/entities/seller_ad_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/entities/job_seeker_ad_entity.dart';
import '../../domain/repositories/ads_repository.dart';
import '../datasource/ads_remote_data_source.dart';

class AdsRepositoryImpl extends AdsRepository {
  final AdsRemoteDataSource _remoteDatasource;

  AdsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<JobSeekerAdEntity>>> fetchJobSeekerAds() async {
    try {
      final List<JobSeekerAdEntity> ads = await _remoteDatasource
          .fetchJobSeekerAds();
      return Right(ads);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }

  @override
  Future<Either<Failure, List<EmployerAdEntity>>> fetchEmployerAds() async {
    try {
      final List<EmployerAdEntity> ads = await _remoteDatasource
          .fetchEmployerAds();
      return Right(ads);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }

  @override
  Future<Either<Failure, List<SellerAdEntity>>> fetchSellerAds() async {
    try {
      final List<SellerAdEntity> ads = await _remoteDatasource.fetchSellerAds();
      return Right(ads);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
