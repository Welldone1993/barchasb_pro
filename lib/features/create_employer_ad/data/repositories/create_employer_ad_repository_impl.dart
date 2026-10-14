import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/repositories/create_employer_ad_repository.dart';
import '../datasources/create_employer_ad_remote_data_source.dart';
import '../dtos/create_employer_ad_dto.dart';
import '../models/job_category_model.dart';

class CreateEmployerAdRepositoryImpl extends CreateEmployerAdRepository {
  final CreateEmployerAdRemoteDataSource _remote;

  CreateEmployerAdRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, dynamic>> createEmployerAd(
    CreateEmployerAdRequestDto employerAd,
  ) async {
    try {
      final dynamic result = await _remote.createEmployerAd(employerAd);

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

  @override
  Future<Either<Failure, dynamic>> getMainCategories() async {
    try {
      final dynamic result = await _remote.getMainCategories();
      final mainCategories = (result.data['categories'] as List)
          .map((e) => JobCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(mainCategories);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getSubCategories(String parentId) async {
    try {
      final dynamic result = await _remote.getSubCategories(parentId);
      final subCategories = (result.data['categories'] as List)
          .map((e) => JobCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(subCategories);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
