import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/create_employer_ad_remote_data_source.dart';
import '../../data/dtos/create_employer_ad_dto.dart';
import '../../data/dtos/employer_ad_category_dto.dart';
import '../../data/dtos/job_detail_dto.dart';
import '../../data/repositories/create_employer_ad_repository_impl.dart';
import '../../domain/entities/create_employer_ad_entity.dart';
import '../../domain/repositories/create_employer_ad_repository.dart';
import 'step_1_provider.dart';
import 'step_2_provider.dart';
import 'step_3_provider.dart';
import 'step_4_provider.dart';

// --- State ---
class EmployerAdState {
  final int currentStep;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  EmployerAdState({
    this.currentStep = 0,
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  EmployerAdState copyWith({
    int? currentStep,
    CreateEmployerAdEntity? adData,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return EmployerAdState(
      currentStep: currentStep ?? this.currentStep,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// --- Provider / Notifier ---
class EmployerAdNotifier extends StateNotifier<EmployerAdState> {
  final Ref ref;
  final CreateEmployerAdRepository repository;

  EmployerAdNotifier(this.ref, this.repository) : super(EmployerAdState());

  void updateData(CreateEmployerAdEntity newData) {
    state = state.copyWith(adData: newData);
  }

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

      final dto = CreateEmployerAdRequestDto(
        // === داده‌های مرحله ۱ ===
        name: step1.name,
        title: step1.title,
        companyDescription: step1.description.isNotEmpty
            ? step1.description
            : null,
        images: (step1.imagePath != null && step1.imagePath!.isNotEmpty)
            ? [step1.imagePath!]
            : [],
        categories: [
          // نکته: در step1 دسته‌بندی به عنوان String ذخیره شده است.
          // باید آیدی واقعی آن را در UI ذخیره کنید یا اینجا تبدیلش کنید.
          EmployerAdCategoryDto(
            categoryId: 1, // مقدار موقت (باید با ID واقعی جایگزین شود)
            name: step1.category, // نام دسته‌بندی
            subCategories: [],
          ),
        ],

        // === داده‌های مرحله ۲ ===
        cooperationType: step2.cooperationType.isNotEmpty
            ? step2.cooperationType
            : null,
        gender: step2.gender.isNotEmpty ? step2.gender : null,
        experience: step2.experience.isNotEmpty ? step2.experience : null,
        paymentMethod: step2.paymentMethod.isNotEmpty
            ? step2.paymentMethod
            : null,
        militaryStatus: step2.militaryStatus.isNotEmpty
            ? step2.militaryStatus
            : null,
        startTime: step2.startTime.isNotEmpty ? step2.startTime : null,
        endTime: step2.endTime.isNotEmpty ? step2.endTime : null,

        // تبدیل رشته‌های حقوق به عدد
        minSalary: num.tryParse(step2.minSalary),
        maxSalary: num.tryParse(step2.maxSalary),

        // ارسال 'سایر ویژگی‌ها' به عنوان جزئیات شغل (JobDetails)
        jobDetails: step2.otherFeatures.isNotEmpty
            ? [
                JobDetailDto(
                  title: 'سایر ویژگی‌ها',
                  description: step2.otherFeatures,
                ),
              ]
            : [],

        // === داده‌های مرحله ۳ ===
        enableChat: step3.isChatEnabled,
        enablePhone: step3.isCallEnabled,
        // توجه: اگر فیلدی برای verificationCode (کد تایید) در DTO دارید:
        // verificationCode: step3.verificationCode,

        // === داده‌های مرحله ۴ ===
        // فیلد پرداخت آگهی (بر اساس enum مرحله 4) - در صورت وجود فیلد مشابه در DTO
        // adPaymentMethod: step4.name, // 'subscription', 'wallet', 'bankCard'
      );
      // ۳. ارسال به ریپازیتوری
      final result = await repository.createEmployerAd(dto);

      // ... ادامه لاجیک fold برای هندل کردن result
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }
}

// پروایدر نهایی که Repository و Ref را به Notifier پاس می‌دهد
final employerAdProvider =
    StateNotifierProvider.autoDispose<EmployerAdNotifier, EmployerAdState>((
      ref,
    ) {
      final dio = ref.watch(dioProvider);
      final remote = CreateEmployerAdRemoteDataSourceImpl(dio);
      final repo = CreateEmployerAdRepositoryImpl(remote);
      return EmployerAdNotifier(ref, repo);
    });
