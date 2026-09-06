import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../models/digital_ad_detail_model.dart';
import '../models/employer_ad_detail_model.dart';
import '../models/job_seeker_ad_detail_model.dart';
import '../models/seller_ad_detail_model.dart';

abstract class AdDetailRemoteDataSource {
  Future<JobSeekerAdDetailModel> getJobSeekerAdById(String id);

  Future<EmployerAdDetailModel> getEmployerAdById(String id);

  Future<DigitalAdDetailModel> getDigitalAdById(String id);

  Future<SellerAdDetailModel> getSellerAdById(String id);
}

class AdDetailRemoteDataSourceImpl implements AdDetailRemoteDataSource {
  final Dio _dio;

  AdDetailRemoteDataSourceImpl(this._dio);

  @override
  Future<JobSeekerAdDetailModel> getJobSeekerAdById(String id) async {
    final response = await _dio.get(ApiEndpoints.jobseekerAdDetail(id));

    return JobSeekerAdDetailModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<EmployerAdDetailModel> getEmployerAdById(String id) async {
    final response = await _dio.get(ApiEndpoints.employerAdDetail(id));

    return EmployerAdDetailModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<DigitalAdDetailModel> getDigitalAdById(String id) async {
    final response = await _dio.get(
        ApiEndpoints.digitalAdAdDetail(id));

    return DigitalAdDetailModel.fromJson(
    response.data as Map<String, dynamic>,
    );
    }

  @override
  Future<SellerAdDetailModel> getSellerAdById(String id) async {
    final response = await _dio.get(ApiEndpoints.sellerAdDetail(id));

    return SellerAdDetailModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

}
