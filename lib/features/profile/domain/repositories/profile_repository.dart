
import 'package:fpdart/fpdart.dart';

import '../entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, UserProfileDataEntity>> getProfile(String userId);
}