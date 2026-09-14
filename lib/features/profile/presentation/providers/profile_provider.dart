import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/profile_datasource.dart';
import '../../data/models/update_profile_dto.dart';
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

// State Model for Profile
class ProfileState {
  final bool isLoading;
  final bool isSaving;
  final bool isUploadingPhoto;
  final UserProfileDataEntity? profileData;
  final String? errorMessage;
  final String? successMessage;

  ProfileState({
    this.isLoading = false,
    this.isSaving = false,
    this.isUploadingPhoto = false,
    this.profileData,
    this.errorMessage,
    this.successMessage,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? isUploadingPhoto,
    UserProfileDataEntity? profileData,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isUploadingPhoto: isUploadingPhoto ?? this.isUploadingPhoto,
      profileData: profileData ?? this.profileData,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }
}

// Profile Notifier
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository repository;

  ProfileNotifier({required this.repository}) : super(ProfileState());

  Future<void> fetchProfile(String userId) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      clearSuccess: true,
    );
    final result = await repository.getProfile(userId);
    result.fold(
      (error) => state = state.copyWith(isLoading: false, errorMessage: error),
      (data) => state = state.copyWith(isLoading: false, profileData: data),
    );
  }

  Future<bool> updateProfile(UpdateProfileDto dto) async {
    state = state.copyWith(
      isSaving: true,
      clearError: true,
      clearSuccess: true,
    );
    final result = await repository.updateProfile(dto);
    return result.fold(
      (error) {
        state = state.copyWith(isSaving: false, errorMessage: error);
        return false;
      },
      (data) {
        state = state.copyWith(
          isSaving: false,
          profileData: data,
          successMessage: 'اطلاعات با موفقیت ذخیره شد.',
        );
        return true;
      },
    );
  }

  Future<bool> uploadProfilePhoto(File file) async {
    state = state.copyWith(
      isUploadingPhoto: true,
      clearError: true,
      clearSuccess: true,
    );
    final result = await repository.uploadProfilePhoto(file);
    return result.fold(
      (error) {
        state = state.copyWith(isUploadingPhoto: false, errorMessage: error);
        return false;
      },
      (imageUrl) {
        state = state.copyWith(
          isUploadingPhoto: false,
          successMessage: 'عکس پروفایل با موفقیت تغییر کرد.',
        );
        return true;
      },
    );
  }
}

final profileNotifierProvider =
StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository: repository);
});

