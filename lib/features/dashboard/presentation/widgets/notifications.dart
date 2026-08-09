import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // رنگ پس‌زمینه روشن صفحه
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // کارت اول: پیام ها
            _buildActionCard(
              context: context,
              title: 'پیام ها',
              bgElements: [
                Positioned(
                  top: -10,
                  left: 10,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: const Icon(Icons.mark_email_read_rounded, size: 60, color: Color(0xFFFCE4E4)), // رنگ صورتی محو
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 20,
                  child: Transform.rotate(
                    angle: 0.3,
                    child: const Icon(Icons.thumb_down_alt_rounded, size: 70, color: Color(0xFFFCE4E4)),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: -20,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: const Icon(Icons.thumb_up_alt_rounded, size: 60, color: Color(0xFFFCE4E4)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30), // فاصله بین دو کارت

            // کارت دوم: پیشنهادات هوشمند
            _buildActionCard(
              context: context,
              title: 'پیشنهادات هوشمند',
              bgElements: [
                Positioned(
                  top: 10,
                  left: -15,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: const Icon(Icons.chat_bubble_rounded, size: 80, color: Color(0xFFE4E6FC)), // رنگ آبی/بنفش محو
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: Transform.rotate(
                    angle: 0.2,
                    child: const Icon(Icons.chat_rounded, size: 50, color: Color(0xFFE4E6FC)),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: 30,
                  child: Transform.rotate(
                    angle: -0.1,
                    child: const Icon(Icons.image_rounded, size: 70, color: Color(0xFFE4E6FC)),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: 20,
                  child: Transform.rotate(
                    angle: 0.2,
                    child: const Icon(Icons.insert_photo_rounded, size: 50, color: Color(0xFFE4E6FC)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // متد سازنده کارت‌ها
  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required List<Widget> bgElements,
  }) {
    return GestureDetector(
      onTap: () {
        // نمایش اسنک‌بار
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'به زودی...',
              style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 14),
              textAlign: TextAlign.right,
            ),
            backgroundColor: const Color(0xFF132F51),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(20),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24), // گوشه‌های گرد
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // سایه بسیار نرم و محو
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // رسم المان‌های محو پس‌زمینه
              ...bgElements,
              // متن اصلی روی کارت
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF132F51), // رنگ سرمه‌ای تیره متن
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Vazirmatn',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
