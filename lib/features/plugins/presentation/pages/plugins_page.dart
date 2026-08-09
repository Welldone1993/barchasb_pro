import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PluginsPage extends ConsumerWidget {
  const PluginsPage({super.key});

  final String targetUrl = 'https://barchasb.org/dashboard/plugins/resume';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 1.0,
      // برای ایجاد کارت‌های مربعی شکل
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // در صورتی که داخل اسکرول‌ویو دیگری قرار دارد
      children: List.generate(4, (index) {
        return _buildGridItem(context);
      }),
    );
  }

  Widget _buildGridItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _launchWebsite(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // تصویر آدمک شما از assets
              Image.asset(
                'assets/backgrounds/job_search.png',
                // مسیر عکس خود را اینجا قرار دهید
                height: 70,
                width: 70,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              const Text(
                'رزومه ساز',
                style: TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A5F), // رنگ سرمه‌ای تیره مشابه تصویر
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchWebsite(BuildContext context) async {
    final Uri url = Uri.parse(targetUrl);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('امکان باز کردن لینک وجود ندارد.')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('خطا در ارتباط با مرورگر')),
        );
      }
    }
  }
}
