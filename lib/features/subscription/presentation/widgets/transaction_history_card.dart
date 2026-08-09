import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/comming_soon_snack_bar.dart';

class TransactionHistoryCard extends ConsumerWidget {
  const TransactionHistoryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHistoryButton(
            context: context,
            title: 'تاریخچه واریز',
            onTap: () {
              // در اینجا می‌توانید با ref مقادیر پرووایدرها را آپدیت کنید
              CustomSnackBar().show(context);
            },
          ),
          const SizedBox(height: 48), // فاصله بین دو دکمه
          _buildHistoryButton(
            context: context,
            title: 'تاریخچه برداشت',
            onTap: () {
              // در اینجا می‌توانید با ref مقادیر پرووایدرها را آپدیت کنید
              CustomSnackBar().show(context);
            },
          ),
        ],
      ),
    );

  // متد کمکی برای ساخت دکمه‌ها
  Widget _buildHistoryButton({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 200, // عرض دکمه‌ها
      height: 55, // ارتفاع دکمه‌ها
      decoration: BoxDecoration(
        color: const Color(0xFF163354), // رنگ سرمه‌ای دکمه‌ها (مشابه تصویر)
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Vazirmatn', // فونت خود را اینجا قرار دهید
              ),
            ),
          ),
        ),
      ),
    );
  }
}
