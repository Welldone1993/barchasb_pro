import 'package:flutter/material.dart';

class DashboardGridButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const DashboardGridButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        // ایجاد رنگ فید شده (گرادیان از روشن به تیره)
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSelected
              ? [
            const Color(0xFF2A4C78).withOpacity(0.9), // آبی روشن‌تر برای بالا-چپ
            const Color(0xFF132F51), // سرمه‌ای تیره برای پایین-راست
          ]
              : [
            const Color(0xFF4A6584).withOpacity(0.7),
            const Color(0xFF2D4560).withOpacity(0.7),
          ],
        ),
        // ایجاد خط براق دور دکمه برای حس شیشه‌ای/برجسته
        border: Border.all(
          color: Colors.white.withOpacity(isSelected ? 0.15 : 0.05),
          width: 1.2,
        ),
        // سایه‌های سه‌بعدی (برجستگی)
        boxShadow: [
          // سایه تیره در پایین و راست (حس ارتفاع)
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(3, 4),
            blurRadius: 8,
          ),
          // سایه روشن (هایلایت) در بالا و چپ (حس تابش نور)
          if (isSelected)
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-1.5, -1.5),
              blurRadius: 4,
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                // یک سایه خیلی محو به متن هم می‌دهیم تا خواناتر شود
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
