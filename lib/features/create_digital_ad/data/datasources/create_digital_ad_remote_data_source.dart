import 'package:barchasb/features/create_digital_ad/data/dtos/create_digital_ad_request_dto.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';

abstract class CreateDigitalAdRemoteDataSource {
  Future<dynamic> createDigitalAd(CreateDigitalAdRequestDto digitalAd);
}

class CreateDigitalAdRemoteDataSourceImpl
    extends CreateDigitalAdRemoteDataSource {
  final Dio _dio;

  CreateDigitalAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createDigitalAd(CreateDigitalAdRequestDto digitalAd) async {
    final response = await _dio.post(
      ApiEndpoints.createDigitalAd,
      data: digitalAd.toJson(),
      // data: FormData.fromMap(digitalAd.toJson()),
    );
    return response;
  }
}
