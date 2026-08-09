import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 32, // عرض دکمه (قابل تغییر)
          height: 32, // ارتفاع دکمه (قابل تغییر)
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF132F51),
              // رنگ آبی تیره مشابه دیزاین شما
              width: 4.0, // ضخامت حاشیه دایره
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_forward_ios_rounded, // آیکون فلش با لبه‌های گرد
              color: Color(0xFF132F51),
              size: 22,
            ),
          ),
        ),
      ),
    ),
  );
}
