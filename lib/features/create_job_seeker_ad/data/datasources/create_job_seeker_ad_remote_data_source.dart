import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../dtos/create_job_seeker_ad_dto.dart';

abstract class CreateJobSeekerAdRemoteDataSource {
  Future<dynamic> createJobSeekerAd(CreateJobSeekerAdRequestDto jobSeekerAd);
}

class CreateJobSeekerAdRemoteDataSourceImpl
    extends CreateJobSeekerAdRemoteDataSource {
  final Dio _dio;

  CreateJobSeekerAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createJobSeekerAd(
    CreateJobSeekerAdRequestDto jobSeekerAd,
  ) async {
    final response = await _dio.post(
      ApiEndpoints.createJobseekerAd,
      data: jobSeekerAd.toFormData(),
    );
    return response;
  }
}
