import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/seller_ad_provider.dart';
import '../providers/step_3_provider.dart';


class Step3VerificationScreen extends ConsumerWidget {
  const Step3VerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(step3Provider);
    final notifier = ref.read(sellerAdProvider.notifier);
    const String phoneNumber = "09035733634"; // TODO: دریافت از پروایدر یا API

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // متن راهنما
            const Text(
              'تائید شماره ی $phoneNumber با کد پیامک',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // فیلد ورود کد
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (val) =>
                    ref.read(step3Provider.notifier).setVerificationCode(val),
                decoration: const InputDecoration(
                  hintText: 'کد ارسال شده را وارد کنید',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // دکمه ارسال کد (متمایل به سمت چپ)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 48,
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B5978), // آبی تیره
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // TODO: فراخوانی متد ارسال یا بررسی مجدد کد پیامک
                  },
                  child: const Text(
                    'ارسال کد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // خط جداکننده (Divider با گرادیان برای افکت محوشدگی در دو طرف)
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.blueGrey,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // چک‌باکس پیام در چت
            _buildCheckboxContainer(
              title: 'پیام در چت برچسب',
              value: formData.isChatEnabled,
              onChanged: (val) =>
                  ref.read(step3Provider.notifier).toggleChatEnabled(val),
            ),
            const SizedBox(height: 16),

            // چک‌باکس تماس تلفنی
            _buildCheckboxContainer(
              title: 'تماس تلفنی',
              value: formData.isCallEnabled,
              onChanged: (val) =>
                  ref.read(step3Provider.notifier).toggleCallEnabled(val),
            ),

            const SizedBox(height: 60),

            // دکمه‌های مرحله قبل و بعد
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF32BDF6), // آبی روشن
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        notifier.prevStep();
                      },
                      child: const Text(
                        'مرحله قبل',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B5978), // آبی تیره
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        notifier.nextStep();
                      },
                      child: const Text(
                        'مرحله بعد',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ویجت سفارشی برای کادرهای چک‌باکس
  Widget _buildCheckboxContainer({
    required String title,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF3B5978),
              fontWeight: FontWeight.bold,
            ),
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B5978),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: Colors.grey, width: 1.5),
          ),
        ],
      ),
    );
  }
}
