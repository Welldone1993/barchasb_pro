import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../dtos/create_employer_ad_dto.dart';

abstract class CreateEmployerAdRemoteDataSource {
  Future<dynamic> createEmployerAd(CreateEmployerAdRequestDto employerAd);
}

class CreateEmployerAdRemoteDataSourceImpl
    extends CreateEmployerAdRemoteDataSource {
  final Dio _dio;

  CreateEmployerAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createEmployerAd(
    CreateEmployerAdRequestDto employerAd,
  ) async {
    final response = await _dio.post(
      ApiEndpoints.createEmployerAd,
      data: employerAd.toFormData(),
    );
    return response;
  }
}
