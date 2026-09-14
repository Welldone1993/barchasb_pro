import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/profile_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return ProfileRemoteDataSourceImpl(dio);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDataSource = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRepositoryImpl(remoteDataSource);
});

// class ProfileNotifier extends StateNotifier<AsyncValue<UserProfileDataEntity>> {
//   final ProfileRepository _repository;
//   final String userId;
//
//   ProfileNotifier(this._repository,this. userId) : super(const AsyncValue.loading()) {
//     fetchProfile(userId);
//   }
//
//   Future<void> fetchProfile(String userId) async {
//     state = const AsyncValue.loading();
//     final result = await _repository.getProfile( userId);
//     result.fold(
//       (error) => state = AsyncValue.error(error, StackTrace.current),
//       (data) => state = AsyncValue.data(data),
//     );
//   }
// }

final profileProvider =FutureProvider.family
    .autoDispose<UserProfileDataEntity, String>((ref, id) async  {
      final repo = ref.watch(profileRepositoryProvider);
      final result = await repo.getProfile(id);
      return result.fold(
            (failure) => throw Exception(failure),
            (profile) => profile,
      );
    });
