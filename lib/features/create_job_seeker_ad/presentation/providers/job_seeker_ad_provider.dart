import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/create_job_seeker_ad_remote_data_source.dart';
import '../../data/dtos/create_job_seeker_ad_dto.dart';
import '../../data/repositories/create_job_seeker_ad_repository_impl.dart';
import '../../domain/repositories/create_job_seeker_ad_repository.dart';
import 'step_1_provider.dart';
import 'step_2_provider.dart';
import 'step_3_provider.dart';
import 'step_4_provider.dart';

// --- State ---
class JobSeekerAdState {
  final int currentStep;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  JobSeekerAdState({
    this.currentStep = 0,
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  JobSeekerAdState copyWith({
    int? currentStep,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return JobSeekerAdState(
      currentStep: currentStep ?? this.currentStep,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// --- Provider / Notifier ---
class JobSeekerAdNotifier extends StateNotifier<JobSeekerAdState> {
  final Ref ref;
  final CreateJobSeekerAdRepository repository;

  JobSeekerAdNotifier(this.ref, this.repository) : super(JobSeekerAdState());

  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void prevStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> submitAd() async {
    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      // ۱. خواندن داده‌ها از پروایدرها
      final step1 = ref.read(step1Provider);
      final step2 = ref.read(step2Provider);
      final step3 = ref.read(step3Provider);
      final step4 = ref.read(step4Provider);

      // ۴. پر کردن DTO با داده‌های جمع‌آوری شده

      final dto = CreateJobSeekerAdRequestDto(
        name: step1.name.isNotEmpty ? step1.name : null,
        age: int.tryParse(step1.age),
        gender: step2.gender.isNotEmpty ? step2.gender : null,
        phoneNumber: step2.phoneNumber.isNotEmpty ? step2.phoneNumber : null,
        state: step2.province.isNotEmpty ? step2.province : null,
        // در استپ ۲ نامش province است
        city: step2.city.isNotEmpty ? step2.city : null,

        // مقادیری که در استپ‌ها وجود ندارند و طبق درخواست شما null گذاشته می‌شوند:
        category: null,
        skills: null,

        suggestedSalaryIRT: num.tryParse(step1.suggestedSalary),
        aboutMe: step2.aboutMe.isNotEmpty ? step2.aboutMe : null,

        // تبدیل تک‌عکس استپ ۱ به لیستِ تصاویر برای DTO
        images: step1.imagePath != null ? [step1.imagePath!] : null,
      );
      // ۳. ارسال به ریپازیتوری
      final result = await repository.createJobSeekerAd(dto);

      // ... ادامه لاجیک fold برای هندل کردن result
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }
}

// پروایدر نهایی که Repository و Ref را به Notifier پاس می‌دهد
final jobSeekerAdProvider =
    StateNotifierProvider.autoDispose<JobSeekerAdNotifier, JobSeekerAdState>((
      ref,
    ) {
      final dio = ref.watch(dioProvider);
      final remote = CreateJobSeekerAdRemoteDataSourceImpl(dio);
      final repo = CreateJobSeekerAdRepositoryImpl(remote);
      return JobSeekerAdNotifier(ref, repo);
    });
