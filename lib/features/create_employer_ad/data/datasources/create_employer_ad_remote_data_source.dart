import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../dtos/create_employer_ad_dto.dart';

abstract class CreateEmployerAdRemoteDataSource {
  Future<dynamic> createEmployerAd(CreateEmployerAdRequestDto employerAd);

  Future<dynamic> sendOtp(String phone);

  Future<dynamic> getMainCategories();

  Future<dynamic> getSubCategories(String parentId);
}

class CreateEmployerAdRemoteDataSourceImpl
    extends CreateEmployerAdRemoteDataSource {
  final Dio _dio;

  CreateEmployerAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createEmployerAd(
    CreateEmployerAdRequestDto employerAd,
  ) async {
    final formData = await employerAd.toFormData();
    final response = await _dio.post(
      ApiEndpoints.createEmployerAd,
      data: formData,
      options: Options(
        contentType: 'multipart/form-data', // بازنویسی برای این درخواست خاص
      ),
    );
    return response;
  }

  @override
  Future<dynamic> sendOtp(String phone) async {
    final response = await _dio.post(
      ApiEndpoints.sendOtp,
      data: {'phone': phone, 'purpose': 'default'},
    );

    return response;
  }

  @override
  Future<dynamic> getMainCategories() async {
    final response = await _dio.get(ApiEndpoints.getMainJobCategories);
    return response;
  }

  @override
  Future<dynamic> getSubCategories(String parentId) async {
    final response = await _dio.get(
      ApiEndpoints.getSubJobCategories,
      queryParameters: {'parentId': parentId},
    );

    return response;
  }
}
