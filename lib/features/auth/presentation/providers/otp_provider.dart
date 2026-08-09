// lib/features/auth/presentation/providers/otp_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/otp_remote_datasource.dart';
import '../../data/repositories/otp_repository_impl.dart';
import '../../domain/repositories/otp_repository.dart';



// تزریق Remote Data Source
final otpRemoteDataSourceProvider = Provider<OtpRemoteDataSource>((ref) {
  return OtpRemoteDataSourceImpl(ref.watch(dioProvider));
});

// تزریق Repository با الگوی جدید
final otpRepositoryProvider = Provider<OtpRepository>((ref) {
  return OtpRepositoryImpl(ref.watch(otpRemoteDataSourceProvider));
});

class OtpState {
  final bool isCaptchaVerified;
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  OtpState({
    this.isCaptchaVerified = false,
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
  });

  OtpState copyWith({
    bool? isCaptchaVerified,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return OtpState(
      isCaptchaVerified: isCaptchaVerified ?? this.isCaptchaVerified,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage, // Nullable override
      errorMessage: errorMessage, // Nullable override
    );
  }
}

class OtpNotifier extends StateNotifier<OtpState> {
  final OtpRepository _repository;

  OtpNotifier(this._repository) : super(OtpState());

  Future<void> sendOtp(String phone, String captchaCode) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );
    try {
      final msg = await _repository.sendOtp(
        phone: phone,
        captchaCode: captchaCode,
      );
      state = state.copyWith(
        isLoading: false,
        isCaptchaVerified: true,
        successMessage: msg, // "کد ارسال شد"
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> verifyOtp(String phone, String otpCode) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );
    try {
      await _repository.verifyOtp(phone: phone, otpCode: otpCode);
      state = state.copyWith(
        isLoading: false,
        successMessage: 'تایید موفقیت آمیز بود',
      );
      // هدایت به صفحه بعد در UI انجام می‌شود
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final otpProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  return OtpNotifier(ref.watch(otpRepositoryProvider));
});
