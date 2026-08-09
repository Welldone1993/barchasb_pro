// lib/features/auth/data/datasources/otp_remote_datasource.dart
import 'package:dio/dio.dart';
import '../models/otp_request_models.dart';

abstract class OtpRemoteDataSource {
  Future<OtpResponseModel> sendOtp(SendOtpRequestModel model);
  Future<OtpResponseModel> verifyOtp(VerifyOtpRequestModel model);
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final Dio _dio;

  OtpRemoteDataSourceImpl(this._dio);

  // در پروژه واقعی آدرس‌ها را از ApiEndpoints بخوانید
  final String sendEndpoint = 'https://barchasb-server.liara.run/api/otp/send';
  final String verifyEndpoint = 'https://barchasb-server.liara.run/api/otp/verify';

  @override
  Future<OtpResponseModel> sendOtp(SendOtpRequestModel model) async {
    final response = await _dio.post(
      sendEndpoint,
      data: model.toJson(),
    );
    return OtpResponseModel.fromJson(response.data);
  }

  @override
  Future<OtpResponseModel> verifyOtp(VerifyOtpRequestModel model) async {
    final response = await _dio.post(
      verifyEndpoint,
      data: model.toJson(),
    );
    return OtpResponseModel.fromJson(response.data);
  }
}
