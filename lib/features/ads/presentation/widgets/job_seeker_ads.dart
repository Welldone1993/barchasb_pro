import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/job_seeker_ad_entity.dart';
import '../providers/job_seeker_ads_provider.dart';

class JobSeekerAdsView extends ConsumerWidget {
  const JobSeekerAdsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adsState = ref.watch(jobSeekerAdsProvider);

    return adsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text('خطا در دریافت اطلاعات\n$error', textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(jobSeekerAdsProvider.notifier).fetchJobSeekerAds(),
              icon: const Icon(Icons.refresh),
              label: const Text('تلاش مجدد'),
            ),
          ],
        ),
      ),
      data: (ads) {
        if (ads.isEmpty) {
          return const Center(child: Text('کارجویی یافت نشد.'));
        }
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(jobSeekerAdsProvider.notifier).fetchJobSeekerAds();
          },
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio:
                  0.62, // در صورت نیاز برای ارتفاع کارت این عدد را تغییر دهید
            ),
            itemCount: ads.length,
            itemBuilder: (context, index) {
              return JobSeekerCard(ad: ads[index]);
            },
          ),
        );
      },
    );
  }
}

class JobSeekerCard extends StatelessWidget {
  final JobSeekerAdEntity ad;

  const JobSeekerCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    const primaryDarkBlue = Color(0xFF133659);

    // ترکیب مهارت‌ها برای نمایش به عنوان شغل (مثلا: sem ، seo)
    // اگر مهارتی نداشت، از category استفاده می‌کنیم
    final String jobSubtitle = ad.skills.isNotEmpty
        ? ad.skills.join(' ، ')
        : (ad.category ?? 'بدون عنوان');

    // ترکیب استان و شهر
    final String location =
        '${ad.state ?? ''} ${ad.city != null ? '، ${ad.city}' : ''}'.trim();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // عکس پروفایل
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey.shade200,
                child: ad.imageUrl != null && ad.imageUrl!.isNotEmpty
                    ? Image.network(
                        ad.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            ),
                      )
                    : const Icon(Icons.person, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),

            // نام کارجو
            Text(
              ad.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: primaryDarkBlue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // مهارت‌ها / عنوان شغلی
            Text(
              jobSubtitle,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: 12),

            // لوکیشن
            _buildBadge(
              text: location.isEmpty ? 'نامشخص' : location,
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 8),

            // امتیاز
            _buildBadge(
              text: '${ad.ratingAverage}/5',
              icon: Icons.star_border_rounded,
            ),

            const Spacer(),

            // دکمه‌های پایین کارت
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.bookmark_border_rounded,
                      color: primaryDarkBlue,
                      size: 20,
                    ),
                    onPressed: () {
                      // عملیات ذخیره
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () {
                        // رفتن به صفحه جزئیات
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'جزئیات',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_back_rounded, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({required String text, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF133659)),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF133659),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
