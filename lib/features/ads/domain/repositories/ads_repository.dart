import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../entities/employer_ad_entity.dart';
import '../entities/job_seeker_ad_entity.dart';
import '../entities/seller_ad_entity.dart';

abstract class AdsRepository {
  Future<Either<Failure, List<JobSeekerAdEntity>>> fetchJobSeekerAds();
  Future<Either<Failure, List<EmployerAdEntity>>> fetchEmployerAds();
  Future<Either<Failure, List<SellerAdEntity>>> fetchSellerAds();
}
