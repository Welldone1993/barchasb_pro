import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// ایمپورت پروایدرهای هر مرحله و DTO
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/create_digital_ad_remote_data_source.dart';
import '../../data/dtos/create_digital_ad_request_dto.dart';
import '../../data/dtos/required_skill_dto.dart';
import '../../data/repositories/create_digital_ad_repository_impl.dart';
import '../../domain/repositories/create_digital_ad_repository.dart';
import 'step_1_provider.dart';
import 'step_2_provider.dart';
import 'step_3_provider.dart';
import 'step_4_provider.dart';

class DigitalAdState {
  final int currentStep;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  DigitalAdState({
    this.currentStep = 0,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  DigitalAdState copyWith({
    int? currentStep,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return DigitalAdState(
      currentStep: currentStep ?? this.currentStep,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}

class DigitalAdNotifier extends StateNotifier<DigitalAdState> {
  final Ref ref;
  final CreateDigitalAdRepository
  repository; // تزریق ریپازیتوری برای ارسال ریکوئست

  DigitalAdNotifier(this.ref, this.repository) : super(DigitalAdState());

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
      final step2Skills = ref.read(step2Provider);
      final step3 = ref.read(step3Provider);
      final step4 = ref.read(step4Provider);

      // ۲. ایجاد DTO با تطبیق دقیق فیلدها
      final dto = CreateDigitalAdRequestDto(
        title: step1.title,
        description: step1.description,
        minBudget: step1.minBudget,
        maxBudget: step1.maxBudget,

        // تبدیل لیست اسکیل‌ها به فرمت مورد نیاز DTO
        requiredSkills: step2Skills
            .map((skill) => RequiredSkillDto(name: skill))
            .toList(),

        // اطلاعات مرحله ۳
        verifyCode: step3.verificationCode,

        // تبدیل Enum به String برای دیتابیس
        paymentMethod: step4.name,

        // تصاویر (اگر فایل هستند ممکن است نیاز به FormData داشته باشید)
        images: step1.photos.isNotEmpty ? step1.photos : null,

        // فیلدهای زیر در DTO شما موجود هستند اما در پروایدرهای فعلی نبودند
        // اگر از قبل مقداری ندارند، null فرستاده می‌شوند
        remote: null,
        // اگر در UI دارید، از پروایدر مربوطه مقداردهی کنید
        thursdayHalf: null,
        // اگر در UI دارید، از پروایدر مربوطه مقداردهی کنید
        durationUnit: null,
        durationAmount: null,
        requestType: 'digital_ad', // مقدار پیش‌فرض اگر لازم است
      );

      // ۳. ارسال به ریپازیتوری
      final result = await repository.createDigitalAd(dto);

      // ... ادامه لاجیک fold برای هندل کردن result
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }
}

// پروایدر نهایی که Repository و Ref را به Notifier پاس می‌دهد
final digitalAdProvider =
    StateNotifierProvider.autoDispose<DigitalAdNotifier, DigitalAdState>((ref) {
      final dio = ref.watch(dioProvider);
      final remote = CreateDigitalAdRemoteDataSourceImpl(dio);
      final repo = CreateDigitalAdRepositoryImpl(remote);
      return DigitalAdNotifier(ref, repo);
    });
