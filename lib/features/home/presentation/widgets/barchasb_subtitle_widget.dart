import 'package:flutter/material.dart';

class BarchasbSubtitle extends StatelessWidget {
  const BarchasbSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    // رنگ آبی تیره/خاکستری که در تصویر برای کلمات برجسته استفاده شده است
    final Color highlightColor = const Color(0xFF4A657A);
    // رنگ خاکستری تیره برای متن معمولی
    final Color normalColor = Colors.grey.shade800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'IRANSans',
              fontSize: 18.0,
              color: normalColor,
            ),
            children: [
              const TextSpan(text: 'جستجوی '),
              TextSpan(
                text: 'برترین کارجویان ',
                style: TextStyle(
                  color: highlightColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(text: 'فقط در '),
              TextSpan(
                text: 'برچسب',
                style: TextStyle(
                  color: highlightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0, // کلمه برچسب در عکس کمی بزرگ‌تر است
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
