import 'package:flutter_riverpod/legacy.dart';

// انواع روش‌های پرداخت
enum PaymentMethod {
  subscription,
  wallet,
  bankCard,
}

// کلاس مدیریت وضعیت مرحله چهارم
class Step4Notifier extends StateNotifier<PaymentMethod> {
  Step4Notifier() : super(PaymentMethod.subscription); // پیش‌فرض روی اشتراک

  void setPaymentMethod(PaymentMethod method) {
    state = method;
  }
}

// پروایدر مرحله چهارم
final step4Provider = StateNotifierProvider<Step4Notifier, PaymentMethod>((ref) {
  return Step4Notifier();
});
