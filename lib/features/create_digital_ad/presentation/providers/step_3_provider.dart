import 'package:flutter_riverpod/legacy.dart';

// مدل داده‌های مرحله سوم
class Step3Data {
  final String verificationCode;
  final bool isChatEnabled;
  final bool isCallEnabled;

  Step3Data({
    this.verificationCode = '',
    this.isChatEnabled = false,
    this.isCallEnabled = false,
  });

  Step3Data copyWith({
    String? verificationCode,
    bool? isChatEnabled,
    bool? isCallEnabled,
  }) {
    return Step3Data(
      verificationCode: verificationCode ?? this.verificationCode,
      isChatEnabled: isChatEnabled ?? this.isChatEnabled,
      isCallEnabled: isCallEnabled ?? this.isCallEnabled,
    );
  }
}

// کلاس مدیریت وضعیت مرحله سوم
class Step3Notifier extends StateNotifier<Step3Data> {
  Step3Notifier() : super(Step3Data());

  void setVerificationCode(String code) {
    state = state.copyWith(verificationCode: code);
  }

  void toggleChatEnabled(bool? value) {
    state = state.copyWith(isChatEnabled: value ?? false);
  }

  void toggleCallEnabled(bool? value) {
    state = state.copyWith(isCallEnabled: value ?? false);
  }
}

// پروایدر مرحله سوم
final step3Provider = StateNotifierProvider<Step3Notifier, Step3Data>((ref) {
  return Step3Notifier();
});
