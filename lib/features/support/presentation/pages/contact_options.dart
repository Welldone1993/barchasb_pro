import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_drawer_menu.dart';
import '../../../../core/widgets/comming_soon_snack_bar.dart';

class ContactOptionsView extends StatelessWidget {
  const ContactOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: const Color(0xFFF5F6F8), // رنگ پس‌زمینه روشن
      // SingleChildScrollView برای جلوگیری از خطای کمبود فضا در صفحه‌های کوچک
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // کارت اول: تماس تلفنی
              _buildSupportCard(
                title: 'تماس تلفنی',
                icon: Icons.phone_android_rounded, // آیکون جایگزین موبایل
                onTap: () {
                  CustomSnackBar().show(context);
                },
              ),

              const SizedBox(height: 20),

              // کارت دوم: چت با ادمین
              _buildSupportCard(
                title: 'چت با ادمین',
                icon: Icons.forum_rounded, // آیکون جایگزین چت
                onTap: () {
                  CustomSnackBar().show(context);
                },
              ),

              const SizedBox(height: 20),

              // کارت سوم: تیکت
              _buildSupportCard(
                title: 'تیکت',
                icon: Icons.local_post_office_rounded,
                // آیکون جایگزین صندوق پست/تیکت
                onTap: () {
                  context.go('/ticket');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    backgroundColor: const Color(0xFF153354),
    // رنگ پس‌زمینه آبی تیره (مطابق تصویر)
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16), // اگر گوشه‌های پایین گرد هستند
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 12.0, bottom: 12.0),
      child: _buildIconButton(
        icon: Icons.search,
        onTap: () {
          // اکشن جستجو
        },
      ),
    ),
    leadingWidth: 70,

    // تنظیم عرض برای جا شدن دکمه
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            _buildIconButton(
              icon: Icons.notifications_none_rounded,
              hasBadge: true,
              badgeCount: '1',
              onTap: () {
                _exitActions(context);
              },
            ),
            const SizedBox(width: 8),

            _buildIconButton(
              icon: Icons.chat_bubble_outline_rounded,
              onTap: () {
                _exitActions(context);
              },
            ),
            const SizedBox(width: 8),

            // دکمه منو (سه نقطه)
            _buildIconButton(
              icon: Icons.more_vert_rounded,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    // برای اینکه پس‌زمینه شفاف باشد (اگر نیاز بود)
                    pageBuilder: (BuildContext context, _, __) {
                      return const PreciseRadialMenu();
                    },
                    transitionsBuilder:
                        (___, Animation<double> animation, ____, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                  ),
                );
              },
            ),
            const SizedBox(width: 16), // فاصله از حاشیه چپ صفحه
          ],
        ),
      ),
    ],
  );

  void _exitActions(BuildContext context) {
    context.go('/dashboard');
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
    String badgeCount = '',
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08), // رنگ نیمه شفاف پس‌زمینه آیکون
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (hasBadge)
              Positioned(
                right: -6,
                bottom: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5252), // رنگ قرمز بج
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badgeCount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // متد سازنده کارت‌ها
  Widget _buildSupportCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 8), // سایه نرم رو به پایین
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // بخش گرافیکی (پس‌زمینه لکه‌ای + آیکون)
            SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // ساخت فرم Blob (قطره‌ای) با کانتینر
                  Positioned(
                    top: 10,
                    child: Transform.rotate(
                      angle: 0.3,
                      child: Container(
                        width: 65,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE6EFFF),
                          // رنگ آبی بسیار روشن پس‌زمینه شکل
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE6EFFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // آیکون اصلی
                  // نکته: اگر عکس اختصاصی دارید، کدهای Icon زیر را حذف کرده و از کد زیر استفاده کنید:
                  // Image.asset('assets/images/your_icon.png', width: 50, height: 50),
                  Icon(
                    icon,
                    size: 45,
                    color: const Color(0xFF4C84F3), // رنگ آبی اختصاصی آیکون‌ها
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // عنوان کارت
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF132F51), // رنگ سرمه‌ای تیره متن
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Vazirmatn', // فونت پروژه
              ),
            ),
          ],
        ),
      ),
    );
  }
}
