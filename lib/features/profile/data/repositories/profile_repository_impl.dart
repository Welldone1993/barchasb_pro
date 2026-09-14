import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<String, UserProfileDataEntity>> getProfile(
    String userId,
  ) async {
    try {
      final profile = await _remoteDataSource.getProfile(userId: userId);
      return Right(profile);
    } on DioException catch (e) {
      final errorMsg =
          e.response?.data?['error'] ??
          e.response?.data?['message'] ??
          'خطای برقراری ارتباط با سرور';
      return Left(errorMsg.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
