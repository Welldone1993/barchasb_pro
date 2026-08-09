import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_drawer_menu.dart';
import '../providers/ticket_provider.dart';

// تبدیل به ConsumerStatefulWidget برای مدیریت Controller ها
class TicketScreen extends ConsumerStatefulWidget {
  const TicketScreen({super.key});

  @override
  ConsumerState<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends ConsumerState<TicketScreen> {
  // تعریف کنترلرها برای هر فیلد
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    // آزاد کردن منابع کنترلرها هنگام خروج از صفحه
    _emailController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticketState = ref.watch(ticketProvider);
    final ticketNotifier = ref.read(ticketProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFE8EEF9),
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            _buildTextField(
              hint: 'ایمیل خود را وارد کنید',
              controller: _emailController, // پاس دادن کنترلر
              onChanged: ticketNotifier.updateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              hint: 'عنوان را وارد کنید',
              controller: _titleController, // پاس دادن کنترلر
              onChanged: ticketNotifier.updateTitle,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              hint: 'توضیحات را بنویسید ...',
              controller: _descriptionController, // پاس دادن کنترلر
              onChanged: ticketNotifier.updateDescription,
              maxLines: 6,
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B5E7B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: ticketState.isLoading
                    ? null
                    : () async {
                        final success = await ticketNotifier.submitTicket();

                        if (success && mounted) {
                          // ۱. پاک کردن استیت در پروایدر
                          ticketNotifier.clearFields();

                          // ۲. پاک کردن محتوای تکست‌فیلدها در UI
                          _emailController.clear();
                          _titleController.clear();
                          _descriptionController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'تیکت با موفقیت ارسال شد',
                                style: TextStyle(fontFamily: 'Vazirmatn'),
                                textAlign: TextAlign.right,
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                child: ticketState.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'ارسال تیکت',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Vazirmatn',
                        ),
                      ),
              ),
            ),
          ],
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

  // اضافه شدن پارامتر controller
  Widget _buildTextField({
    required String hint,
    required Function(String) onChanged,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        // اعمال کنترلر
        onChanged: onChanged,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: const TextStyle(
          fontFamily: 'Vazirmatn',
          color: Color(0xFF132F51),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFB4BCC8),
            fontFamily: 'Vazirmatn',
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
