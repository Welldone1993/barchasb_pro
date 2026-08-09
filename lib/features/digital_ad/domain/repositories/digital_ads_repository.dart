import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../entities/digital_ad_entity.dart';

abstract class DigitalAdsRepository {
  Future<Either<Failure, List<CreateDigitalAdEntity>>> fetchDigitalAds({
    required String search,
  });
}
