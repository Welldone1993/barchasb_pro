import 'package:barchasb/features/dashboard/presentation/widgets/add_ad_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/widgets/app_drawer_menu.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../ads/presentation/pages/ads_page.dart';
import '../../../digital_ad/presentation/pages/digital_ad_page.dart';
import '../../../my_ads/presentation/pages/my_ads_page.dart';
import '../../../plugins/presentation/pages/plugins_page.dart';
import '../../../subscription/presentation/pages/subscription_page.dart';
import '../../../work_space/presentation/pages/work_space_page.dart';
import '../widgets/dashboard_grid_button.dart';
import '../widgets/notifications.dart';
import '../../../support/presentation/pages/support.dart';
import '../widgets/user_profile_card.dart';

final selectedDashboardSectionProvider = StateProvider<int>((ref) => 0);

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedDashboardSectionProvider);
    final List<String> buttonTitles = [
      'میزکار',
      'آگهی ها',
      'آگهی دیجیتال',
      'آگهی های من',
      'اشتراک و مالی',
      'افزونه ها',
    ];

    return AppScaffold(
      appBar: _appBar(ref, context),
      title: 'داشبورد کاربر',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(selectedDashboardSectionProvider.notifier).state = 6;
        },
        backgroundColor: const Color(0xFF1E3A5F),
        // رنگ آبی تیره (مطابق تصویر)
        foregroundColor: Colors.white,
        // رنگ آیکون
        elevation: 4.0,
        // سایه زیر دکمه
        shape: const CircleBorder(),
        // این خط دکمه را کاملاً گرد می‌کند
        child: const Icon(
          Icons.add,
          size: 32, // اندازه آیکون +
        ),
      ),

      body: Column(
        children: [
          UserProfileCard(),
          Expanded(
            child: Column(
              children: [
                // گرید دکمه‌ها
                _tabsGridView(buttonTitles, selectedIndex, ref),

                const SizedBox(height: 8),

                // بخش نمایش محتوا بر اساس دکمه انتخاب شده
                Expanded(
                  child: Container(
                    padding: EdgeInsetsGeometry.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5F7),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: _buildSectionContent(selectedIndex, context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(WidgetRef ref, BuildContext context) => AppBar(
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
                ref.read(selectedDashboardSectionProvider.notifier).state = 7;
              },
            ),
            const SizedBox(width: 8),

            _buildIconButton(
              icon: Icons.chat_bubble_outline_rounded,
              onTap: () {
                ref.read(selectedDashboardSectionProvider.notifier).state = 8;
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

  Widget _tabsGridView(
    List<String> buttonTitles,
    int selectedIndex,
    WidgetRef ref,
  ) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttonTitles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 ستون (مانند عکس)
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.2, // تنظیم نسبت عرض به ارتفاع دکمه‌ها
      ),
      itemBuilder: (context, index) => DashboardGridButton(
        title: buttonTitles[index],
        isSelected: selectedIndex == index,
        onTap: () {
          ref.read(selectedDashboardSectionProvider.notifier).state = index;
        },
      ),
    ),
  );

  Widget _buildSectionContent(int index, BuildContext context) {
    switch (index) {
      case 0:
        return WorkSpacePage();
      case 1:
        return AdsPage();
      case 2:
        return DigitalAdPage();
      case 3:
        return MyAdsPage();
      case 4:
        return SubscriptionPage();
      case 5:
        return PluginsPage();
      case 6:
        return const AddAdSection();
      case 7:
        return const NotificationsScreen();
      case 8:
        return const SupportScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
