import 'package:flutter/material.dart';

import '../../../../core/widgets/comming_soon_snack_bar.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/backgrounds/rectangle.jpg',
                fit: BoxFit.cover,
                // در صورت نیاز به هندل کردن خطا قبل از اضافه کردن به پاب‌اسپک
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    ': موجودی حساب',
                    style: TextStyle(
                      fontFamily: 'Vazirmatn', // یا فونت دلخواه شما
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A5F), // رنگ سرمه‌ای تیره متن
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Balance Box - Toman
                  _buildBalanceBox(label: 'تومان', value: '45.000.000'),
                  const SizedBox(height: 16),

                  // Balance Box - Club Points
                  _buildBalanceBox(label: 'امتیاز کلاب', value: '12.000'),
                  const SizedBox(height: 32),

                  // Action Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        title: 'واریز',
                        onTap: () {
                          CustomSnackBar().show(context);
                        },
                      ),
                      _buildActionButton(
                        title: 'تبدیل',
                        onTap: () {
                          CustomSnackBar().show(context);
                        },
                      ),
                      _buildActionButton(
                        title: 'برداشت',
                        onTap: () {
                          CustomSnackBar().show(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  Widget _buildBalanceBox({required String label, required String value}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA), // رنگ پس‌زمینه خاکستری/آبی خیلی روشن
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Value Part
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A5F),
                ),
              ),
            ),
          ),

          // Divider
          Container(width: 1, height: 24, color: Colors.grey.withOpacity(0.4)),

          // Label Part
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3A5F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFF2C4A73), // رنگ سرمه‌ای دکمه‌ها
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Vazirmatn',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
