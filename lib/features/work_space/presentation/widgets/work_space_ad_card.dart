import 'package:flutter/material.dart';

import '../../domain/entities/ad_entity.dart';

class WorkSpaceAdCard extends StatelessWidget {
  final AdEntity ad; // نوع داده را از dynamic به AdEntity تغییر دادیم
  final VoidCallback? onUpPressed;
  final VoidCallback? onDownPressed;

  const WorkSpaceAdCard({
    super.key,
    required this.ad,
    this.onUpPressed,
    this.onDownPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 350), // محدودیت عرض برای فرم‌های بزرگتر
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // گوشه تا شده
          Positioned(
            top: -1,
            left: -1,
            child: CustomPaint(
              size: const Size(70, 70),
              painter: FoldedCornerPainter(),
            ),
          ),

          // محتوای اصلی کارت
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 40.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,// مهم: برای جلوگیری از Overflow
                children: [
                  // عکس پروفایل/آگهی با هاله کم‌رنگ
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      // بررسی وجود عکس و نمایش یک عکس پیش‌فرض در صورت نبود آن
                      backgroundImage: (ad.imageUrl != null && ad.imageUrl!.isNotEmpty)
                          ? NetworkImage(ad.imageUrl!)
                          : const NetworkImage('https://via.placeholder.com/150?text=No+Image') as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // عنوان آگهی
                  Text(
                    ad.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // دسته‌بندی یا نام فرد ثبت‌کننده
                  Text(
                    ad.category ?? ad.subCategories ?? 'بدون دسته‌بندی',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // بج (Badge) - نمایش قیمت یا وضعیت
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ad.price != null
                          ? '${ad.price} تومان'
                          :'وضعیت نامشخص',
                      style: const TextStyle(
                        color: Color(0xFF1E3A5F),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // تگ‌های پایین (تولید پویا بر اساس اطلاعات آگهی)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      if (ad.state != null) _buildTag(ad.state!),
                      if (ad.city != null) _buildTag(ad.city!),
                      if (ad.isNegotiable) _buildTag('قابل مذاکره'),
                      if (ad.hasWarranty) _buildTag('گارانتی‌دار'),
                      if (ad.isShippable) _buildTag('قابل ارسال'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // تب نارنجی بالا
          Positioned(
            top: -15,
            left: 0,
            right: 0,
            child: Center(
              child: _OrangeTab(
                isTop: true,
                onTap: onUpPressed,
                isActive: onUpPressed != null,
              ),
            ),
          ),

          // تب نارنجی پایین
          Positioned(
            bottom: -15,
            left: 0,
            right: 0,
            child: Center(
              child: _OrangeTab(
                isTop: false,
                onTap: onDownPressed,
                isActive: onDownPressed != null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
    );
  }
}

// دکمه‌های تب نارنجی با قابلیت کلیک
class _OrangeTab extends StatelessWidget {
  final bool isTop;
  final VoidCallback? onTap;
  final bool isActive;

  const _OrangeTab({
    required this.isTop,
    this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.4, // اگر آگهی قبلی/بعدی نبود، دکمه کمرنگ شود
        child: Container(
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFF68D38),
            borderRadius: isTop
                ? const BorderRadius.vertical(top: Radius.circular(30))
                : const BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Icon(
            isTop ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

// رسم گوشه تا شده (انحنای ملایم‌تر)
class FoldedCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E3A5F)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    // ایجاد حالت کمی خمیده برای تای کاغذ
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.8, size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
