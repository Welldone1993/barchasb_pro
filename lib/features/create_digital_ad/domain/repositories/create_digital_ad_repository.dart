import 'package:barchasb/features/create_digital_ad/data/dtos/create_digital_ad_request_dto.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../../digital_ad/domain/entities/digital_ad_entity.dart';

abstract class CreateDigitalAdRepository {
  Future<Either<Failure, CreateDigitalAdEntity>> createDigitalAd(CreateDigitalAdRequestDto digitalAd);
}
