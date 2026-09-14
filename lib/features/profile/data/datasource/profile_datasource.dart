import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileDataModel> getProfile({String? userId});
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
}
