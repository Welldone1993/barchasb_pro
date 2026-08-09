import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../models/digital_ad_model.dart';

abstract class DigitalAdsRemoteDataSource {
  Future<List<DigitalAdModel>> fetchDigitalAds({required String search});
}

class DigitalAdsRemoteDataSourceImpl implements DigitalAdsRemoteDataSource {
  final Dio _dio;

  DigitalAdsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<DigitalAdModel>> fetchDigitalAds({required String search}) async {
    final response = await _dio.get(
      ApiEndpoints.digitalAds,
      queryParameters: {'?Search': search},
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => DigitalAdModel.fromJson(json)).toList();
  }
}
