import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

 import '../providers/seller_ad_provider.dart';
import '../providers/step_1_provider.dart';
import '../providers/step_2_provider.dart';
import '../providers/step_3_provider.dart';
import '../providers/step_4_provider.dart';

class Step5WaitingScreen extends ConsumerWidget {
  const Step5WaitingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // رنگ پس‌زمینه خاکستری روشن
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),

              // کارت سفید رنگ وسط صفحه
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // عنوان نارنجی
                    const Text(
                      'در انتظار تائید . . .',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE88A4A), // رنگ نارنجی مشابه تصویر
                      ),
                    ),
                    const SizedBox(height: 40),

                    // انیمیشن لودینگ
                    // نکته: برای لودینگ نقطه‌ای دقیقاً مشابه تصویر می‌توانید از پکیج flutter_spinkit
                    // و ویجت SpinKitFadingCircle استفاده کنید. در اینجا از لودینگ پیش‌فرض فلاتر استفاده شده.
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        color: Color(0xFFE88A4A),
                        strokeWidth: 4,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // متن توضیحات
                    const Text(
                      'جزئیات آگهی به پشتیبانی فرستاده شد و در حال بررسی است\nلطفا صبور باشید',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7B8B9E), // رنگ طوسی/آبی ملایم
                        height: 1.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // دکمه بازگشت به میز کار
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B5978), // رنگ آبی تیره
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    ref.invalidate(sellerAdProvider);
                    ref.invalidate(step1Provider);
                     ref.invalidate(step2Provider);
                    ref.invalidate(step3Provider);
                    ref.invalidate(step4Provider);
                    context.go('/dashboard');
                  },
                  child: const Text(
                    'برو به میز کار',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Vazirmatn', // یا فونت دلخواه شما
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
