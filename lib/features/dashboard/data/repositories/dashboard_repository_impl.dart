import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> fetchUser() async {
    try {
      final UserEntity userModel = await _remoteDataSource.fetchUser();
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
