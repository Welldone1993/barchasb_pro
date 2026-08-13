import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../dtos/create_job_seeker_ad_dto.dart';

abstract class CreateJobSeekerAdRemoteDataSource {
  Future<dynamic> createJobSeekerAd(CreateJobSeekerAdRequestDto jobSeekerAd);

  Future<dynamic> sendOtp(String phone);
}

class CreateJobSeekerAdRemoteDataSourceImpl
    extends CreateJobSeekerAdRemoteDataSource {
  final Dio _dio;

  CreateJobSeekerAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createJobSeekerAd(
    CreateJobSeekerAdRequestDto jobSeekerAd,
  ) async {
    final formData = await jobSeekerAd.toFormData();
    final response = await _dio.post(
      ApiEndpoints.createJobseekerAd,
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
