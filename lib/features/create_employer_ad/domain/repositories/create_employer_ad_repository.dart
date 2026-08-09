import 'package:barchasb/features/create_digital_ad/data/dtos/create_digital_ad_request_dto.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../../digital_ad/domain/entities/digital_ad_entity.dart';
import '../../data/dtos/create_employer_ad_dto.dart';
import '../entities/create_employer_ad_entity.dart';

abstract class CreateEmployerAdRepository {
  Future<Either<Failure, CreateEmployerAdEntity>> createEmployerAd(
    CreateEmployerAdRequestDto employerAd,
  );
}
