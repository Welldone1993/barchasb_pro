import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAdSection extends StatelessWidget {
  const AddAdSection({super.key});

  // رنگ‌های استفاده شده در طراحی بر اساس تصویر
  final Color _primaryBlue = const Color(0xFF1E3A5F); // رنگ متن (آبی تیره)
  final Color _lightBlueBg = const Color(
    0xFFE6EFFF,
  ); // رنگ پس‌زمینه دکمه‌ها (آبی روشن)
  final Color _lineColor = const Color(0xFFD0E0FF); // رنگ خط رابط

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // عنوان اصلی
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              decoration: BoxDecoration(
                color: _lightBlueBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'ثبت آگهی به عنوان',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _primaryBlue,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // دکمه کارفرما
            _buildMenuButton(
              context,
              title: 'کارفرما',
              onTap: () => context.pushReplacement('/create_employer_ad'),
            ),

            _buildConnectorLine(),

            // دکمه کارجو
            _buildMenuButton(
              context,
              title: 'کارجو',
              onTap: () => context.pushReplacement('/create_job_seeker_ad'),
            ),

            _buildConnectorLine(),

            // دکمه آگهی گذار
            _buildMenuButton(
              context,
              title: 'آگهی گذار',
              onTap: () => context.pushReplacement('/create_seller_ad'),
            ),

            _buildConnectorLine(),

            // دکمه آگهی دیجیتال
            _buildMenuButton(
              context,
              title: 'آگهی دیجیتال',
              onTap: () => context.pushReplacement('/create_digital_ad'),
            ),
          ],
        ),
      ),
    );
  }

  // --- ویجت سازنده دکمه‌های منو ---
  Widget _buildMenuButton(BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 220,
          // عرض ثابت برای دکمه‌ها
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _lightBlueBg,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _primaryBlue,
            ),
          ),
        ),
      ),
    );
  }

  // --- خط رابط بین دکمه‌ها ---
  Widget _buildConnectorLine() {
    return Container(
      width: 2,
      height: 30, // طول خط رابط
      color: _lineColor,
    );
  }
}
