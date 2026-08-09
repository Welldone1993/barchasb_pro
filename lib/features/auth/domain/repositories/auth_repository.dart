import 'package:barchasb/features/auth/domain/entities/province_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../entities/login_entity.dart';
import '../entities/register_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(String phone, String password);

  Future<Either<Failure, dynamic>> register(RegisterEntity registerData);

  Future<Either<Failure, List<ProvinceEntity>>> getProvinces();
}
