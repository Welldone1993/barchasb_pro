// lib/features/ads/presentation/pages/job_seeker_ad_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/job_seeker_ad_detail_provider.dart';

class JobSeekerAdDetailPage extends ConsumerWidget {
  final String adId;

  const JobSeekerAdDetailPage({
    super.key,
    required this.adId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // گوش دادن به وضعیت آگهی بر اساس شناسه
    final adDetailAsync = ref.watch(jobSeekerAdDetailProvider(adId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات آگهی کارجو'),
        centerTitle: true,
      ),
      body: adDetailAsync.when(
        // حالت لودینگ
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        // حالت خطا همراه با دکمه تلاش مجدد
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.redAccent,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  error.toString().replaceFirst('Exception: ', ''),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // ریفرش و تلاش مجدد برای دریافت اطلاعات
                    ref.refresh(jobSeekerAdDetailProvider(adId));
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('تلاش مجدد'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // حالت موفقیت‌آمیز (نمایش داده‌ها)
        data: (ad) => RefreshIndicator(
          onRefresh: () async {
            return ref.refresh(jobSeekerAdDetailProvider(adId).future);
          },
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(
                'نام کارجو: ${ad.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('دسته‌بندی: ${ad.category}'),
              Text('استان / شهر: ${ad.state} - ${ad.city}'),
              Text('شماره تماس: ${ad.phoneNumber}'),
              Text('حقوق پیشنهادی: ${ad.suggestedSalaryIRT} تومان'),
              const Divider(height: 32),
              const Text(
                'درباره من:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(ad.aboutMe.isNotEmpty ? ad.aboutMe : 'توضیحاتی ثبت نشده است.'),
            ],
          ),
        ),
      ),
    );
  }
}
