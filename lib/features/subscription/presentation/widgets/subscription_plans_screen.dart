import 'package:barchasb/core/widgets/comming_soon_snack_bar.dart';
import 'package:flutter/material.dart';

class SubscriptionPlansCard extends StatelessWidget {
  const SubscriptionPlansCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),

          // تصویر گرافیکی (دوشاخه و متن اشتراک ندارید)
          // لطفاً تصویر مربوطه را در مسیر assets پروژه خود قرار دهید
          Image.asset(
            'assets/backgrounds/rectangle.jpg', // مسیر فرضی عکس شما
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // در صورتی که عکس هنوز اضافه نشده باشد، این بخش موقتاً نمایش داده می‌شود
              return Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EFFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'تصویر «اشتراک ندارید!!»',
                    style: TextStyle(
                      fontFamily: 'Vazirmatn',
                      color: Color(0xFF2C4A73),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 48),

          Material(
            color: const Color(0xFF1E3A5F), // رنگ سرمه‌ای دکمه
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () => CustomSnackBar().show(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 14,
                ),
                child: const Text(
                  'خرید اشتراک',
                  style: TextStyle(
                    fontFamily: 'Vazirmatn',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
