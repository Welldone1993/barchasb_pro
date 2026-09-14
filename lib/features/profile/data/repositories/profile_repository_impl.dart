import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_datasource.dart';
import '../models/update_profile_dto.dart';

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

  @override
  Future<Either<String, dynamic>> updateProfile(UpdateProfileDto dto) async {
    try {
      final model = await _remoteDataSource.updateProfile(dto);
      return Right(model);
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] ??
          e.response?.data?['message'] ??
          'خطا در به‌روزرسانی پروفایل';
      return Left(msg.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadProfilePhoto(File imageFile) async {
    try {
      final imageUrl = await _remoteDataSource.uploadProfilePhoto(imageFile);
      return Right(imageUrl);
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] ??
          e.response?.data?['message'] ??
          'خطا در آپلود عکس پروفایل';
      return Left(msg.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
