import 'package:flutter_riverpod/legacy.dart';

class Step2Data {
  final String cooperationType; // نوع همکاری
  final String gender; // جنسیت
  final String experience; // سابقه
  final String paymentMethod; // شیوه پرداخت
  final String minSalary; // حداقل حقوق
  final String maxSalary; // حداکثر حقوق
  final String startTime; // ساعت شروع کار
  final String endTime; // ساعت پایان کار
  final String militaryStatus; // وضعیت سربازی
  final String otherFeatures; // سایر ویژگی ها

  Step2Data({
    this.cooperationType = '',
    this.gender = '',
    this.experience = '',
    this.paymentMethod = '',
    this.minSalary = '',
    this.maxSalary = '',
    this.startTime = '',
    this.endTime = '',
    this.militaryStatus = '',
    this.otherFeatures = '',
  });

  Step2Data copyWith({
    String? cooperationType,
    String? gender,
    String? experience,
    String? paymentMethod,
    String? minSalary,
    String? maxSalary,
    String? startTime,
    String? endTime,
    String? militaryStatus,
    String? otherFeatures,
  }) {
    return Step2Data(
      cooperationType: cooperationType ?? this.cooperationType,
      gender: gender ?? this.gender,
      experience: experience ?? this.experience,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      militaryStatus: militaryStatus ?? this.militaryStatus,
      otherFeatures: otherFeatures ?? this.otherFeatures,
    );
  }
}

class Step2Notifier extends StateNotifier<Step2Data> {
  Step2Notifier() : super(Step2Data());

  void updateData({
    String? cooperationType,
    String? gender,
    String? experience,
    String? paymentMethod,
    String? minSalary,
    String? maxSalary,
    String? startTime,
    String? endTime,
    String? militaryStatus,
    String? otherFeatures,
  }) {
    state = state.copyWith(
      cooperationType: cooperationType,
      gender: gender,
      experience: experience,
      paymentMethod: paymentMethod,
      minSalary: minSalary,
      maxSalary: maxSalary,
      startTime: startTime,
      endTime: endTime,
      militaryStatus: militaryStatus,
      otherFeatures: otherFeatures,
    );
  }
}

final step2Provider = StateNotifierProvider<Step2Notifier, Step2Data>((ref) {
  return Step2Notifier();
});
