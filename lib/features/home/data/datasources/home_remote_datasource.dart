import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/ad_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<AdModel>> getSellers(String? query);

  Future<List<AdModel>> getEmployers(String? query);

  Future<List<AdModel>> getJobSeekers(String? query);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<AdModel>> getSellers(String? query) async =>
      _getAds(ApiEndpoints.sellerAds, query);

  @override
  Future<List<AdModel>> getEmployers(String? query) async =>
      _getAds(ApiEndpoints.employerAds, query);

  @override
  Future<List<AdModel>> getJobSeekers(String? query) async =>
      _getAds(ApiEndpoints.jobseekerAds, query);

  Future<List<AdModel>> _getAds(String url, String? query) async {
    final response = await _dio.get(
      url,
      queryParameters: (query != null && query.isNotEmpty)
          ? {'q': query}
          : null,
    );
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
