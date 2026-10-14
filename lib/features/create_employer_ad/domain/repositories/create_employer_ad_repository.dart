import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../data/dtos/create_employer_ad_dto.dart';

abstract class CreateEmployerAdRepository {
  Future<Either<Failure, dynamic>> createEmployerAd(
    CreateEmployerAdRequestDto employerAd,
  );

  Future<Either<Failure, dynamic>> sendOtp(String phone);

  Future<Either<Failure, dynamic>> getMainCategories();

  Future<Either<Failure, dynamic>> getSubCategories(String parentId);
 }
