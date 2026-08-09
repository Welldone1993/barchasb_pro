import 'package:barchasb/features/auth/domain/entities/province_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;

  AuthRepositoryImpl(this._remote);

  LoginEntity _toLoginEntity(LoginResponseModel model) {
    final userEntity = UserEntity(
      id: model.user.id,
      name: model.user.name,
      lastName: model.user.lastName,
      phone: model.user.phone,
      role: model.user.role,
    );

    return LoginEntity(
      message: model.message,
      user: userEntity,
      token: model.token,
    );
  }

  @override
  Future<Either<Failure, LoginEntity>> login(
    String phone,
    String password,
  ) async {
    final request = LoginRequestModel(phone: phone, password: password);
    try {
      final LoginResponseModel responseModel = await _remote.login(request);
      return Right(_toLoginEntity(responseModel));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  UserEntity _toUserEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      lastName: model.lastName,
      phone: model.phone,
      role: model.role,
    );
  }

  @override
  Future<Either<Failure, dynamic>> register(
    RegisterEntity registerData,
  ) async {
    final requestModel = RegisterRequestModel(
      firstName: registerData.firstName,
      lastName: registerData.lastName,
      phoneNumber: registerData.phoneNumber,
      nationalId: registerData.nationalId,
      birthDate: registerData.birthDate,
      gender: registerData.gender == 'مرد' ? 'male' : 'female',
      province: registerData.province,
      city: registerData.city,
      password: registerData.password,
    );
    try {
      final responseModel = await _remote.register(requestModel);
      return Right(responseModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProvinceEntity>>> getProvinces() async {
    try {
      final response = await _remote.getProvinces();
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message ?? 'خطا در دریافت اطلاعات از سرور'));
    }
  }
}
