import 'package:fpdart/fpdart.dart';
import '../../../../core/utils/failure.dart'; // این فایل را باید بسازید
import '../entities/ad_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<AdEntity>>> getSellers();
  Future<Either<Failure, List<AdEntity>>> getEmployers();
  Future<Either<Failure, List<AdEntity>>> getJobSeekers();
}
