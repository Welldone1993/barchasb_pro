import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // رنگ پس‌زمینه روشن صفحه
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // کارت اول: سوالات متداول
            _buildSupportCard(
              title: 'سوالات متداول',
              icon: Icons.search_rounded, // آیکون جستجو
              onTap: () {
                context.go('/faq_screen');
              },
            ),

            const SizedBox(height: 30), // فاصله بین دو کارت
            // کارت دوم: ارتباط با ادمین
            _buildSupportCard(
              title: 'ارتباط با ادمین',
              icon: Icons.forum_rounded, // آیکون چت و گفتگو
              onTap: () {
                context.go('/contact_options');
              },
            ),
          ],
        ),
      ),
    );
  }

  // متد سازنده کارت‌های پشتیبانی
  Widget _buildSupportCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap, // اجرای تابع پاس داده شده (در اینجا خالی است)
      child: Container(
        width: 170,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), // گوشه‌های گرد کارت
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // سایه بسیار نرم کارت
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // بخش گرافیکی (آیکون + پس‌زمینه لکه‌ای/Blob)
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // شبیه‌سازی لکه (Blob) آبی روشن در پس‌زمینه
                  Positioned(
                    top: 10,
                    child: Transform.rotate(
                      angle: 0.5,
                      child: Container(
                        width: 60,
                        height: 55,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE4EDFF), // رنگ آبی روشن
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // یک لکه دایره‌ای کوچک برای طبیعی‌تر شدن فرم
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4EDFF).withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // آیکون اصلی روی لکه
                  Icon(
                    icon,
                    size: 40,
                    color: const Color(0xFF2B70FA), // رنگ آبی پررنگ آیکون
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // عنوان کارت
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF132F51), // رنگ سرمه‌ای متن
                fontSize: 17,
                fontWeight: FontWeight.w700,
                fontFamily: 'Vazirmatn', // فونت وزیرمتن
              ),
            ),
          ],
        ),
      ),
    );
  }
}
