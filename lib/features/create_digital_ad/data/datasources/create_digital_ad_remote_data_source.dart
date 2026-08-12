import 'package:barchasb/features/create_digital_ad/data/dtos/create_digital_ad_request_dto.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';

abstract class CreateDigitalAdRemoteDataSource {
  Future<dynamic> createDigitalAd(CreateDigitalAdRequestDto digitalAd);

  Future<dynamic> sendOtp(String phone);
}

class CreateDigitalAdRemoteDataSourceImpl
    extends CreateDigitalAdRemoteDataSource {
  final Dio _dio;

  CreateDigitalAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createDigitalAd(CreateDigitalAdRequestDto digitalAd) async {
    final formData = await digitalAd.toFormData();
    final response = await _dio.post(
      ApiEndpoints.createDigitalAd,
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
}
