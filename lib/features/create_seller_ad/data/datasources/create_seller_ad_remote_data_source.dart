import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../dtos/create_seller_ad_dto.dart';

abstract class CreateSellerAdRemoteDataSource {
  Future<dynamic> createSellerAd(CreateSellerAdDto sellerAd);
}

class CreateSellerAdRemoteDataSourceImpl
    extends CreateSellerAdRemoteDataSource {
  final Dio _dio;

  CreateSellerAdRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> createSellerAd(CreateSellerAdDto sellerAd) async {
    final response = await _dio.post(
      ApiEndpoints.createJobseekerAd,
      data: sellerAd.toFormData(),
    );
    return response;
  }
}
