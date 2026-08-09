import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_drawer_menu.dart';
import '../providers/step_1_provider.dart';
import '../providers/step_2_provider.dart';
import '../providers/step_3_provider.dart';
import '../providers/step_4_provider.dart';
import '../providers/seller_ad_provider.dart';
import '../widgets/step_1.dart';
import '../widgets/step_2.dart';
import '../widgets/step_3.dart';
import '../widgets/step_4.dart';
import '../widgets/step_5.dart';

class SellerAddScreen extends ConsumerStatefulWidget {
  const SellerAddScreen({super.key});

  @override
  ConsumerState<SellerAddScreen> createState() => _SellerAddScreenState();
}

class _SellerAddScreenState extends ConsumerState<SellerAddScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sellerAdProvider);

    // گوش دادن به تغییرات استپ برای انیمیشن PageView
    ref.listen<SellerAdState>(sellerAdProvider, (previous, next) {
      if (previous?.currentStep != next.currentStep) {
        _pageController.animateToPage(
          next.currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      appBar: _appBar(ref, context),
      backgroundColor: Color(0xFF153354),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: const Color(0xFFF5F7FA),
              ),
              child: Column(
                children: [
                  // هدر استپر (سفارشی و غیرقابل کلیک)
                  _buildStepperHeader(state.currentStep),
                  const SizedBox(height: 24),

                  // محتوای مراحل
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      // جلوگیری از سوایپ دستی
                      children: [
                        Step1BasicInfoScreen(),
                        Step2SellerAdInfoScreen(),
                        Step3VerificationScreen(),
                        Step4PaymentScreen(),
                        Step5WaitingScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _exit(),
          ],
        ),
      ),
    );
  }

  Widget _exit() => Positioned(
    top: 20,
    left: 20,
    child: GestureDetector(
      onTap: () {
        _exitActions(ref, context);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: const Color(0xFFF05252), // رنگ قرمز مشابه تصویر
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
      ),
    ),
  );

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
                _exitActions(ref, context);
              },
            ),
            const SizedBox(width: 8),

            _buildIconButton(
              icon: Icons.chat_bubble_outline_rounded,
              onTap: () {
                _exitActions(ref, context);
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

  void _exitActions(WidgetRef ref, BuildContext context) {
    ref.invalidate(sellerAdProvider);
    ref.invalidate(step1Provider);
    ref.invalidate(step2Provider);
    ref.invalidate(step3Provider);
    ref.invalidate(step4Provider);
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

  // --- استپر سفارشی بالای صفحه ---
  Widget _buildStepperHeader(int currentStep) {
    List<Widget> stepperWidgets = [];
    for (int i = 0; i < 5; i++) {
      bool isPassedOrCurrent = i <= currentStep;

      // دایره استپ
      stepperWidgets.add(
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPassedOrCurrent ? const Color(0xFF2C4B6B) : Colors.white,
            border: Border.all(color: const Color(0xFF2C4B6B), width: 1.5),
          ),
        ),
      );

      // خط رابط (به جز آیتم آخر)
      if (i < 4) {
        stepperWidgets.add(
          Expanded(
            child: Container(
              height: 2,
              color: isPassedOrCurrent
                  ? const Color(0xFF2C4B6B)
                  : Colors.grey.shade400,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: stepperWidgets,
      ),
    );
  }
}
