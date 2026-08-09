import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

abstract class DashboardRemoteDataSource {
  Future<UserModel> fetchUser();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl(this._dio);

  @override
  Future<UserModel> fetchUser() async {
    final response = await _dio.get(ApiEndpoints.getUser);

    return UserModel.fromJson(response.data);
  }
}
