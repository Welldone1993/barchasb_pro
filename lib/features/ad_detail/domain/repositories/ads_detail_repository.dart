import 'package:fpdart/fpdart.dart';

import '../entities/employer_ad_detail_entity.dart';
import '../entities/job_seeker_ad_detail_entity.dart';

abstract class AdDetailRepository {
  Future<Either<String, JobSeekerAdDetailEntity>> getJobSeekerAdById(String id);
  Future<Either<String, EmployerAdDetailEntity>> getEmployerAdById(String id);
  // Future<Either<String, DigitalAdDetailEntity>> getDigitalAdById(String id);
  // Future<Either<String, SellerAdDetailEntity>> getSellerAdById(String id);
}