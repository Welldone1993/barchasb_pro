import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../models/employer_ad_model.dart';
import '../models/job_seeker_ad_model.dart';
import '../models/seller_ad_model.dart';

abstract class AdsRemoteDataSource {
  Future<List<JobSeekerAdModel>> fetchJobSeekerAds();

  Future<List<EmployerAdModel>> fetchEmployerAds();

  Future<List<SellerAdModel>> fetchSellerAds();
}

class AdsRemoteDataSourceImpl implements AdsRemoteDataSource {
  final Dio _dio;

  AdsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<JobSeekerAdModel>> fetchJobSeekerAds() async {
    final response = await _dio.get(ApiEndpoints.jobseekerAds);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => JobSeekerAdModel.fromJson(json)).toList();
  }

  @override
  Future<List<EmployerAdModel>> fetchEmployerAds() async {
    final response = await _dio.get(ApiEndpoints.employerAds);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => EmployerAdModel.fromJson(json)).toList();
  }

  @override
  Future<List<SellerAdModel>> fetchSellerAds() async {
    final response = await _dio.get(ApiEndpoints.sellerAds);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => SellerAdModel.fromJson(json)).toList();
  }
}
