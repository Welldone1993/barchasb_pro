import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/widgets/comming_soon_snack_bar.dart';
import '../../data/datasources/create_digital_ad_remote_data_source.dart';
import '../../data/repositories/create_digital_ad_repository_impl.dart';
import '../../domain/repositories/create_digital_ad_repository.dart';

// مدل داده‌های مرحله سوم
class Step3Data {
  final String verificationCode;
  final String phoneNumber;
  final bool isChatEnabled;
  final bool isCallEnabled;

  Step3Data({
    this.verificationCode = '',
    this.isChatEnabled = false,
    this.isCallEnabled = false,
    this.phoneNumber = '',
  });

  Step3Data copyWith({
    String? verificationCode,
    String? phoneNumber,
    bool? isChatEnabled,
    bool? isCallEnabled,
  }) {
    return Step3Data(
      verificationCode: verificationCode ?? this.verificationCode,
      isChatEnabled: isChatEnabled ?? this.isChatEnabled,
      isCallEnabled: isCallEnabled ?? this.isCallEnabled,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

// کلاس مدیریت وضعیت مرحله سوم
class Step3Notifier extends StateNotifier<Step3Data> {
  final Ref ref;
  final CreateDigitalAdRepository repository;

  Step3Notifier(this.ref, this.repository) : super(Step3Data()) {
    getPhoneNumber();
  }

  Future<void> getPhoneNumber() async {
    final storage = ref.read(secureStorageProvider);
    final token = await storage.read(key: 'auth_token');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token ?? '');
    // return decodedToken['phone'];
    state = state.copyWith(phoneNumber: decodedToken['phone']);
  }

  void setVerificationCode(String code) {
    state = state.copyWith(verificationCode: code);
  }

  void toggleChatEnabled(bool? value) {
    state = state.copyWith(isChatEnabled: value ?? false);
  }

  void toggleCallEnabled(bool? value) {
    state = state.copyWith(isCallEnabled: value ?? false);
  }

  Future<void> sendOtp(BuildContext context, String phoneNumber) async {
    final result = await repository.sendOtp(phoneNumber);
    if (context.mounted) {
      CustomSnackBar(title: 'کد ارسال شد').show(context);
    }
  }
}

// پروایدر مرحله سوم
final step3Provider =
    StateNotifierProvider.autoDispose<Step3Notifier, Step3Data>((ref) {
      final dio = ref.watch(dioProvider);
      final remote = CreateDigitalAdRemoteDataSourceImpl(dio);
      final repo = CreateDigitalAdRepositoryImpl(remote);
      return Step3Notifier(ref, repo);
    });
