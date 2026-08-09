import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../models/ad_model.dart';
import '../models/weekly_stats_model.dart';

abstract class WorkSpaceRemoteDataSource {
  Future<List<AdModel>> fetchAds();

  Future<List<WeeklyStatsModel>> fetchWeeklyStats();
}

class WorkSpaceRemoteDataSourceImpl implements WorkSpaceRemoteDataSource {
  final Dio _dio;

  WorkSpaceRemoteDataSourceImpl(this._dio);

  @override
  Future<List<AdModel>> fetchAds() async {
    final response = await _dio.get(ApiEndpoints.sellerAds);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => AdModel.fromJson(json)).toList();
  }

  @override
  Future<List<WeeklyStatsModel>> fetchWeeklyStats() async {
    final response = await _dio.get(ApiEndpoints.weeklyStats);

    return response.data
        .map((json) => WeeklyStatsModel.fromJson(json))
        .toList();
  }
}
