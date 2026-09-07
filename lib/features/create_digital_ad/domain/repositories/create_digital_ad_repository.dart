import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../data/dtos/create_digital_ad_request_dto.dart';

abstract class CreateDigitalAdRepository {
  Future<Either<Failure, dynamic>> createDigitalAd(CreateDigitalAdRequestDto digitalAd);
  Future<Either<Failure,dynamic>> sendOtp(String phone);
}
