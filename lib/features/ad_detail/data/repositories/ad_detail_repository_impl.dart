import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/digital_ad_detail_entity.dart';
import '../../domain/entities/employer_ad_detail_entity.dart';
import '../../domain/entities/job_seeker_ad_detail_entity.dart';
import '../../domain/entities/seller_ad_detail_entity.dart';
import '../../domain/repositories/ads_detail_repository.dart';
import '../datasource/ad_detail_remote_data_source.dart';

class AdDetailRepositoryImpl implements AdDetailRepository {
  final AdDetailRemoteDataSource _remoteDataSource;

  AdDetailRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<String, JobSeekerAdDetailEntity>> getJobSeekerAdById(
    String id,
  ) async {
    try {
      final result = await _remoteDataSource.getJobSeekerAdById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(
        e.response?.data?['error'] ?? e.message ?? 'خطا در برقراری ارتباط',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, EmployerAdDetailEntity>> getEmployerAdById(
    String id,
  ) async {
    try {
      final result = await _remoteDataSource.getEmployerAdById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(
        e.response?.data?['error'] ?? e.message ?? 'خطا در برقراری ارتباط',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DigitalAdDetailEntity>> getDigitalAdById(
    String id,
  ) async {
    try {
      final result = await _remoteDataSource.getDigitalAdById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(
        e.response?.data?['error'] ?? e.message ?? 'خطا در برقراری ارتباط',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, SellerAdDetailEntity>> getSellerAdById(
    String id,
  ) async {
    try {
      final result = await _remoteDataSource.getSellerAdById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(
        e.response?.data?['error'] ?? e.message ?? 'خطا در برقراری ارتباط',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
