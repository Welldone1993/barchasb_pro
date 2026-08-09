import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/create_seller_ad_remote_data_source.dart';
import '../../data/dtos/create_seller_ad_dto.dart';
import '../../data/repositories/create_seller_ad_repository_impl.dart';
import '../../domain/repositories/create_seller_ad_repository.dart';
import 'step_1_provider.dart';
import 'step_2_provider.dart';
import 'step_3_provider.dart';
import 'step_4_provider.dart';

// --- State ---
class SellerAdState {
  final int currentStep;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  SellerAdState({
    this.currentStep = 0,
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  SellerAdState copyWith({
    int? currentStep,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SellerAdState(
      currentStep: currentStep ?? this.currentStep,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// --- Provider / Notifier ---
class SellerAdNotifier extends StateNotifier<SellerAdState> {
  final Ref ref;
  final CreateSellerAdRepository repository;

  SellerAdNotifier(this.ref, this.repository) : super(SellerAdState());

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
      // تجمیع فیلدهایی که در دیتابیس ستون اختصاصی ندارند داخل یک مپ
      final extraFeatures = <String, dynamic>{
        if (step1.description.isNotEmpty) 'description': step1.description,

        // ویژگی‌های مرحله دوم
        if (step2.condition.isNotEmpty) 'condition': step2.condition,
        if (step2.usage.isNotEmpty) 'usage': step2.usage,
        if (step2.toolType.isNotEmpty) 'toolType': step2.toolType,
        if (step2.brand.isNotEmpty) 'brand': step2.brand,
        if (step2.model.isNotEmpty) 'model': step2.model,
        if (step2.power.isNotEmpty) 'power': step2.power,
        if (step2.technicalSpecs.isNotEmpty)
          'technicalSpecs': step2.technicalSpecs,
        if (step2.includedItems.isNotEmpty)
          'includedItems': step2.includedItems,
        if (step2.warrantyMonths.isNotEmpty)
          'warrantyMonths': step2.warrantyMonths,

        // تنظیمات تماس از مرحله سوم
        'verificationCode': step3.verificationCode,
        'isChatEnabled': step3.isChatEnabled,
        'isCallEnabled': step3.isCallEnabled,
      };

      final dto = CreateSellerAdDto(
        // مقادیر مرحله ۱
        title: step1.title.isNotEmpty ? step1.title : null,
        category: step1.category.isNotEmpty ? step1.category : null,
        images: step1.imagePaths.isNotEmpty ? step1.imagePaths : null,
        mainImageIndex: step1.imagePaths.isNotEmpty ? 0 : null,
        // پیش‌فرض عکس اول

        // مقادیر مرحله ۲
        state: step2.province.isNotEmpty ? step2.province : null,
        city: step2.city.isNotEmpty ? step2.city : null,
        priceIRT: num.tryParse(step2.price),
        // تبدیل رشته به عدد
        isFixedPrice: step2.isFixedPrice,
        isNegotiable: step2.isExchangeable,
        // isExchangeable نقش همان قابل مذاکره/معاوضه را دارد
        hasWarranty: step2.hasWarranty,
        isShippable: step2.canShip,

        // مقادیر مرحله ۳ و اضافی
        extraFeatures: extraFeatures.isNotEmpty ? extraFeatures : null,
        person: null,
        // اگر شخص/شرکت بودن در استیت‌ها وجود ندارد نال ارسال می‌کنیم

        // مقادیر مرحله ۴ (تبدیل Enum به رشته)
        paymentMethod: step4.name,
      );
      // ۳. ارسال به ریپازیتوری
      final result = await repository.createSellerAd(dto);

      // ... ادامه لاجیک fold برای هندل کردن result
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }
}

// پروایدر نهایی که Repository و Ref را به Notifier پاس می‌دهد
final sellerAdProvider =
    StateNotifierProvider.autoDispose<SellerAdNotifier, SellerAdState>((ref) {
      final dio = ref.watch(dioProvider);
      final remote = CreateSellerAdRemoteDataSourceImpl(dio);
      final repo = CreateSellerAdRepositoryImpl(remote);
      return SellerAdNotifier(ref, repo);
    });
