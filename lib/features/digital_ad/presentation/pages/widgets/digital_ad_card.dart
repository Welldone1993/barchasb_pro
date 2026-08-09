import 'package:flutter/material.dart';

import '../../../domain/entities/digital_ad_entity.dart';

class DigitalAdCard extends StatelessWidget {
  final CreateDigitalAdEntity
  digitalAd; // اگر مدل خاصی دارید (مثل AdEntity) آن را جایگزین dynamic کنید

  const DigitalAdCard({super.key, required this.digitalAd});

  @override
  Widget build(BuildContext context) {
    // رنگ سرمه‌ای استفاده شده در متون و دکمه‌ها
    const primaryColor = Color(0xFF17304C);

    return Container(
      width: double.infinity,
      // ❌ دقت کنید که اینجا به هیچ وجه نباید ویژگی height تنظیم شود ❌
      padding: const EdgeInsets.all(16),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // این خط باعث می‌شود ارتفاع به اندازه محتوا باشد و ارور ندهد
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- بخش اول: عکس، عنوان و زمان ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. باکس عکس (سمت راست)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                // در آینده اگر عکس داشتید:
                // child: Image.network(digitalAd.image, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),

              // 2. عنوان و نشانگر زمان
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان آگهی
                    Expanded(
                      child: Text(
                        digitalAd.title,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),

                    // نشانگر زمان (سمت چپ)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '5 دقیقه پیش', // این مقدار را می‌توانید داینامیک کنید
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // --- بخش دوم: توضیحات ---
          Text(
            digitalAd.description ?? 'هیچ توضیحی برای آگهی اضافه نشده...',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
              height: 1.6,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          // --- بخش سوم: دکمه‌ها ---
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // قرار دادن دکمه‌ها در انتهای سطر (سمت چپ)
            children: [
              // دکمه سیو / بوکمارک
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.bookmark_add_outlined,
                    color: primaryColor,
                    size: 22,
                  ),
                  onPressed: () {
                    // عملکرد ذخیره
                  },
                ),
              ),
              const SizedBox(width: 8),

              // دکمه جزئیات
              SizedBox(
                height: 38,
                child: OutlinedButton(
                  onPressed: () {
                    // عملکرد مشاهده جزئیات
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: const Text(
                    'جزئیات',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
