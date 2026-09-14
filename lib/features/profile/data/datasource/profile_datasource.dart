import 'dart:io';

import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/update_profile_dto.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileDataModel> getProfile({String? userId});
  Future<UserProfileDataModel> updateProfile(UpdateProfileDto dto);
  Future<String> uploadProfilePhoto(File imageFile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfileDataModel> getProfile({String? userId}) async {
    final response = await _dio.get(
      ApiEndpoints.getProfile,
      queryParameters: userId != null ? {'userId': userId} : null,
    );

    return UserProfileDataModel.fromJson(response.data);
  }
  @override
  Future<UserProfileDataModel> updateProfile(UpdateProfileDto dto) async {
    final response = await _dio.put(
      ApiEndpoints.updateProfile,
      data: dto.toJson(),
    );
    return UserProfileDataModel.fromJson(response.data);
  }

  @override
  Future<String> uploadProfilePhoto(File imageFile) async {
    final fileName = imageFile.path.split('/').last;
    final formData = FormData.fromMap({
      'profileImage': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    final response = await _dio.post(
      ApiEndpoints.updateProfilePhoto,
      data: formData,
    );

    // سرور ممکن است فیلد profileImage یا آدرس فایل بازگرداند
    if (response.data is Map<String, dynamic>) {
      return response.data['profileImage'] ?? response.data['url'] ?? response.data['file'] ?? '';
    }
    return response.data.toString();
  }
}
