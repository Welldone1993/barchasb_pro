import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/digital_ad_entity.dart';
import 'digital_ads_provider.dart';

// ایمپورت فایل پروایدری که خودتون نوشتید
// import 'digital_ads_provider.dart';
// ایمپورت مدل
// import '../../domain/entities/digital_ad_entity.dart';

// پروایدر برای نگهداری متن جستجو
final searchQueryProvider = StateProvider<String>((ref) => '');

// پروایدر ترکیبی: لیست اصلی را می‌گیرد و اگر متنی سرچ شده باشد، آن را فیلتر می‌کند
final filteredDigitalAdsProvider = Provider<AsyncValue<List<CreateDigitalAdEntity>>>((
  ref,
) {
  final adsState = ref.watch(digitalAdsProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  // اگر سرچ خالی است، همان لیست اصلی را برگردان
  if (searchQuery.isEmpty) {
    return adsState;
  }

  // اگر دیتا لود شده بود، فیلتر را اعمال کن
  return adsState.whenData((ads) {
    return ads.where((ad) {
      // جستجو در عنوان یا توضیحات (می‌توانید فیلدهای دلخواه را اضافه کنید)
      return ad.title.toLowerCase().contains(searchQuery) ||
          (ad.description ?? '').toLowerCase().contains(searchQuery);
    }).toList();
  });
});
