import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/seller_ad_provider.dart';
import '../providers/step_4_provider.dart';

class Step4PaymentScreen extends ConsumerWidget {
  const Step4PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPaymentMethod = ref.watch(step4Provider);
    final notifier = ref.read(sellerAdProvider.notifier);

    // TODO: دریافت این مقادیر از API یا پروایدر اطلاعات کاربر
    const int subscriptionPoints = 3;
    const String walletBalance = "100.000";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // کادر تعداد امتیاز اشتراک
            _buildInfoChip('تعداد امتیاز اشتراک : $subscriptionPoints'),
            const SizedBox(height: 16),

            // کادر موجودی کیف پول
            _buildInfoChip('موجودی کیف پول : $walletBalance تومان'),
            const SizedBox(height: 40),

            // گزینه‌های پرداخت
            _buildPaymentOption(
              context: context,
              ref: ref,
              title: 'پرداخت از طریق اشتراک',
              value: PaymentMethod.subscription,
              groupValue: selectedPaymentMethod,
            ),
            const SizedBox(height: 16),

            _buildPaymentOption(
              context: context,
              ref: ref,
              title: 'پرداخت از طریق کیف پول',
              value: PaymentMethod.wallet,
              groupValue: selectedPaymentMethod,
            ),
            const SizedBox(height: 16),

            _buildPaymentOption(
              context: context,
              ref: ref,
              title: 'پرداخت با کارت بانکی',
              value: PaymentMethod.bankCard,
              groupValue: selectedPaymentMethod,
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
                        notifier.submitAd();
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

  // ویجت برای کادرهای اطلاعات (بالای صفحه)
  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF3B5978),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ویجت برای گزینه‌های پرداخت
  Widget _buildPaymentOption({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required PaymentMethod value,
    required PaymentMethod groupValue,
  }) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        ref.read(step4Provider.notifier).setPaymentMethod(value);
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9EDF4) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B5978) : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF3B5978),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Icon(
              isSelected
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked,
              color: const Color(0xFF3B5978),
            ),
          ],
        ),
      ),
    );
  }
}
