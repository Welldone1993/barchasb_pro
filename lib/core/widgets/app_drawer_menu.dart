import 'package:barchasb/core/network/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';

class PreciseRadialMenu extends ConsumerWidget {
  const PreciseRadialMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF132F51), // رنگ پس‌زمینه سرمه‌ای دقیق
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          // شعاع داخلی و خارجی قطاع‌ها
          const double innerRadius = 110.0;
          const double outerRadius = 280.0;
          const double iconRadius =
              (innerRadius + outerRadius) / 2; // محل قرارگیری آیکون‌ها

          return Stack(
            children: [
              // رسم اشکال هندسی پس‌زمینه منوها
              GestureDetector(
                onTapUp: (details) {
                  _handleTap(
                    context,
                    ref,
                    details.localPosition,
                    width,
                    height,
                    innerRadius,
                    outerRadius,
                  );
                },
                child: CustomPaint(
                  size: Size(width, height),
                  painter: _MenuPainter(
                    innerRadius: innerRadius,
                    outerRadius: outerRadius,
                  ),
                ),
              ),

              // --- دکمه‌های گوشه بالا چپ ---
              // دکمه خروج/بستن (مرکز بالا چپ)
              Positioned(
                top: 30,
                left: 30,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      color: const Color(0xFF1A385E),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
              // آیکون خانه (زاویه 15 درجه)
              _buildIcon(0, 0, 15, iconRadius, Icons.home_outlined, 'خانه'),
              // آیکون خروج (زاویه 45 درجه)
              _buildIcon(0, 0, 45, iconRadius, Icons.logout, 'خروج'),
              // آیکون پشتیبانی (زاویه 75 درجه)
              _buildIcon(
                0,
                0,
                75,
                iconRadius,
                Icons.headset_mic_outlined,
                'پشتیبانی',
              ),

              // --- دکمه‌های گوشه پایین راست ---
              // آیکون ذخیره ها (زاویه 195 درجه)
              _buildIcon(
                width,
                height,
                195,
                iconRadius,
                Icons.bookmark_border,
                'ذخیره ها',
              ),
              // آیکون آگهی ها (زاویه 225 درجه)
              _buildIcon(
                width,
                height,
                225,
                iconRadius,
                Icons.calendar_today_outlined,
                'آگهی ها',
              ),
              // آیکون اشتراک (زاویه 255 درجه)
              _buildIcon(
                width,
                height,
                255,
                iconRadius,
                Icons.diamond_outlined,
                'اشتراک',
              ),

              // دایره توخالی پایین سمت راست
              Positioned(
                bottom: 30,
                right: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              // --- دکمه‌های مرکزی ---
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCenterButton(
                      'رزومه ساز',
                      Icons.contact_page_outlined,
                      onTap: () {
                        context.pop();
                        context.go('/dashboard');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildCenterButton(
                      'مقالات',
                      Icons.article_outlined,
                      onTap: () {
                        context.pop();
                        context.go('/');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildCenterButton(
                      'اتاق خبر',
                      Icons.language,
                      onTap: () {
                        context.pop();
                        context.go('/');
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // متد رسم آیکون‌ها و متون بر اساس زاویه روی دایره
  Widget _buildIcon(
    double cx,
    double cy,
    double angleDegrees,
    double radius,
    IconData icon,
    String label,
  ) {
    double angleRadians = angleDegrees * math.pi / 180;
    double x = cx + radius * math.cos(angleRadians);
    double y = cy + radius * math.sin(angleRadians);

    return Positioned(
      left: x - 40, // تنظیم تقریبی وسط
      top: y - 35,
      child: IgnorePointer(
        // جلوگیری از تداخل با GestureDetector پایینی
        child: SizedBox(
          width: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Vazirmatn',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // متد ساخت دکمه‌های عریض وسط صفحه
  Widget _buildCenterButton(
    String text,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Vazirmatn',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تشخیص دقیق محل کلیک بر اساس فرمول‌های ریاضی و زوایا
  void _handleTap(
    BuildContext context,
    WidgetRef ref,
    Offset localPosition,
    double width,
    double height,
    double innerR,
    double outerR,
  ) async {
    final x = localPosition.dx;
    final y = localPosition.dy;

    // بررسی منوی بالا چپ (مرکز 0,0)
    final distTL = math.sqrt(x * x + y * y);
    if (distTL >= innerR && distTL <= outerR) {
      final angle = math.atan2(y, x) * 180 / math.pi; // 0 تا 90
      if (angle >= 0 && angle < 30) {
        print("خانه کلیک شد");
        context.pop();
        context.go('/');
      } else if (angle >= 30 && angle < 60) {
        print("خروج کلیک شد");
        final storage = ref.read(secureStorageProvider);
        await storage.delete(key: 'auth_token');
        if (context.mounted) {
          context.go('/');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('با موفقیت خارج شدید')));
        }
      } else if (angle >= 60 && angle <= 90) {
        print("پشتیبانی کلیک شد");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تسک انجام نشده')));
      }
      return;
    }

    // بررسی منوی پایین راست (مرکز width, height)
    final dxBR = x - width;
    final dyBR = y - height;
    final distBR = math.sqrt(dxBR * dxBR + dyBR * dyBR);
    if (distBR >= innerR && distBR <= outerR) {
      double angle = math.atan2(dyBR, dxBR) * 180 / math.pi;
      if (angle < 0) angle += 360; // تبدیل به بازه 180 تا 270

      if (angle >= 180 && angle < 210) {
        print("ذخیره ها کلیک شد");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تسک انجام نشده')));
      } else if (angle >= 210 && angle < 240) {
        print("آگهی ها کلیک شد");
        context.pop();
        context.go('/dashboard');
      } else if (angle >= 240 && angle <= 270) {
        print("اشتراک کلیک شد");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تسک انجام نشده')));
      }
    }
  }
}

// کلاس رسم کننده (Custom Painter) برای قطاع‌های رنگی
class _MenuPainter extends CustomPainter {
  final double innerRadius;
  final double outerRadius;

  _MenuPainter({required this.innerRadius, required this.outerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final centerTL = const Offset(0, 0);
    final centerBR = Offset(size.width, size.height);

    final defaultColor = Colors.white.withOpacity(0.08);
    final gapSweep = 29.0 * math.pi / 180; // 1 درجه فاصله برای خطوط جداکننده
    final thirtyDeg = 30.0 * math.pi / 180;

    // رسم قطاع‌های بالا-چپ
    _drawSlice(canvas, centerTL, 0, gapSweep, defaultColor); // خانه
    _drawSlice(
      canvas,
      centerTL,
      thirtyDeg,
      gapSweep,
      const Color(0xFFE54B4B),
    ); // خروج (قرمز)
    _drawSlice(
      canvas,
      centerTL,
      thirtyDeg * 2,
      gapSweep,
      defaultColor,
    ); // پشتیبانی

    // رسم قطاع‌های پایین-راست
    final start180 = 180.0 * math.pi / 180;
    final start210 = 210.0 * math.pi / 180;
    final start240 = 240.0 * math.pi / 180;

    _drawSlice(canvas, centerBR, start180, gapSweep, defaultColor); // ذخیره‌ها
    _drawSlice(
      canvas,
      centerBR,
      start210,
      gapSweep,
      const Color(0xFFF7941D),
    ); // آگهی‌ها (نارنجی)
    _drawSlice(canvas, centerBR, start240, gapSweep, defaultColor); // اشتراک
  }

  void _drawSlice(
    Canvas canvas,
    Offset center,
    double startAngle,
    double sweepAngle,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..arcTo(
        Rect.fromCircle(center: center, radius: innerRadius),
        startAngle,
        sweepAngle,
        true,
      )
      ..arcTo(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle + sweepAngle,
        -sweepAngle,
        false,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
