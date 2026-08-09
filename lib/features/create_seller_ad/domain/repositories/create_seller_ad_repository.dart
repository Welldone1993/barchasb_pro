import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../../data/dtos/create_seller_ad_dto.dart';
import '../entities/create_seller_ad_entity.dart';

abstract class CreateSellerAdRepository {
  Future<Either<Failure, CreateSellerAdEntity>> createSellerAd(
    CreateSellerAdDto jobSeekerAd,
  );
}
