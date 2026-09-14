
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../data/models/update_profile_dto.dart';
import '../entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, UserProfileDataEntity>> getProfile(String userId);
  Future<Either<String, String>> uploadProfilePhoto(File imageFile);
  Future<Either<String, dynamic>> updateProfile(UpdateProfileDto dto);
}