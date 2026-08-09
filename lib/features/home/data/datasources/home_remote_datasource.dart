import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/ad_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<AdModel>> getSellers();

  Future<List<AdModel>> getEmployers();

  Future<List<AdModel>> getJobSeekers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<AdModel>> getSellers() async => _getAds(ApiEndpoints.sellerAds);

  @override
  Future<List<AdModel>> getEmployers() async =>
      _getAds(ApiEndpoints.employerAds);

  @override
  Future<List<AdModel>> getJobSeekers() async =>
      _getAds(ApiEndpoints.jobseekerAds);

  Future<List<AdModel>> _getAds(String url) async {
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => AdModel.fromJson(json)).toList();
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to load ads',
      );
    }
  }
}
