import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/failure.dart';
import '../entities/user_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, UserEntity>> fetchUser();
}
