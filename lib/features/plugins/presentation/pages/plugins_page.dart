import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PluginsPage extends ConsumerWidget {
  const PluginsPage({super.key});

  final String resumeUrl = 'https://barchasb.org/dashboard/plugins/resume';
  final String testUrl = 'https://barchasb.org/dashboard/plugins/tests';
  final String converterUrl =
      'https://barchasb.org/dashboard/plugins/converter';

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
      children: [
        _buildGridItem(
          context,
          imagePath: '📄',
          title: 'رزومه ساز',
          targetUrl: resumeUrl,
        ),
        _buildGridItem(
          context,
          imagePath: '🧠',
          title: 'آزمون ها',
          targetUrl: testUrl,
        ),
        _buildGridItem(
          context,
          imagePath: '🔁',
          title: 'تبدیل ها',
          targetUrl: converterUrl,
        ),
      ],
    );
  }

  Widget _buildGridItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String targetUrl,
  }) => Container(
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
        onTap: () => _launchWebsite(context, targetUrl: targetUrl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(imagePath, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text(
              title,
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

  Future<void> _launchWebsite(
    BuildContext context, {
    required String targetUrl,
  }) async {
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
