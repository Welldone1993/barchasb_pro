import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/failure.dart';
import '../../domain/entities/ad_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<AdEntity>>> getSellers({String? query}) async =>
      _repoCall(_remoteDataSource.getSellers, query);

  @override
  Future<Either<Failure, List<AdEntity>>> getEmployers({String? query}) async =>
      _repoCall(_remoteDataSource.getEmployers, query);

  @override
  Future<Either<Failure, List<AdEntity>>> getJobSeekers({
    String? query,
  }) async => _repoCall(_remoteDataSource.getJobSeekers, query);

  // یک تابع کمکی برای کاهش تکرار کد
  Future<Either<Failure, List<AdEntity>>> _repoCall(
    Future<List<AdEntity>> Function(String? query) call,
    String? query,
  ) async {
    try {
      final result = await call(query);
      return right(result);
    } on DioException catch (e) {
      return left(Failure(e.message ?? 'An unknown error occurred.'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
