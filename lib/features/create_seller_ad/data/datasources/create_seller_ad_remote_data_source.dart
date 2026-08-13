import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../dtos/create_seller_ad_dto.dart';

abstract class CreateSellerAdRemoteDataSource {
  Future<dynamic> createSellerAd(CreateSellerAdDto sellerAd);

  Future<dynamic> sendOtp(String phone);
}

class CreateSellerAdRemoteDataSourceImpl
    extends CreateSellerAdRemoteDataSource {
  final Dio _dio;

  CreateSellerAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createSellerAd(CreateSellerAdDto sellerAd) async {
    final formData = await sellerAd.toFormData();
    final response = await _dio.post(
      ApiEndpoints.createSellerAd,
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
