import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/entities/create_seller_ad_entity.dart';
// import 'create_seller_ad_entity.dart'; // آدرس فایل انتیتی خود را ایمپورت کنید

class CreateSellerAdDto extends CreateSellerAdEntity {
  CreateSellerAdDto({
    super.title,
    super.category,
    super.state,
    super.city,
    super.priceIRT,
    super.isFixedPrice,
    super.isNegotiable,
    super.hasWarranty,
    super.isShippable,
    super.extraFeatures,
    super.mainImageIndex,
    super.person,
    super.paymentMethod,
    super.images,
  });

  /// تبدیل مدل به FormData برای ارسال با پکیج Dio
  Future<FormData> toFormData() async {
    final formData = FormData();

    // فیلدهای متنی
    if (title != null) formData.fields.add(MapEntry('title', title!));
    if (category != null) formData.fields.add(MapEntry('category', category!));
    if (state != null) formData.fields.add(MapEntry('state', state!));
    if (city != null) formData.fields.add(MapEntry('city', city!));
    if (person != null) formData.fields.add(MapEntry('person', person!));
    if (paymentMethod != null) formData.fields.add(MapEntry('paymentMethod', paymentMethod!));

    // فیلدهای عددی و بولین (در فرم‌دیتا باید به رشته تبدیل شوند)
    if (priceIRT != null) formData.fields.add(MapEntry('priceIRT', priceIRT.toString()));
    if (mainImageIndex != null) formData.fields.add(MapEntry('mainImageIndex', mainImageIndex.toString()));
    if (isFixedPrice != null) formData.fields.add(MapEntry('isFixedPrice', isFixedPrice.toString()));
    if (isNegotiable != null) formData.fields.add(MapEntry('isNegotiable', isNegotiable.toString()));
    if (hasWarranty != null) formData.fields.add(MapEntry('hasWarranty', hasWarranty.toString()));
    if (isShippable != null) formData.fields.add(MapEntry('isShippable', isShippable.toString()));

    // آبجکتِ ویژگی‌های اضافه (تبدیل به JSON String)
    if (extraFeatures != null) {
      formData.fields.add(MapEntry('extraFeatures', jsonEncode(extraFeatures)));
    }

    // فایل‌های تصویری (آپلود تا ۹ عکس)
    if (images != null && images!.isNotEmpty) {
      for (String path in images!) {
        formData.files.add(
          MapEntry(
            'images', // این کلید دقیقاً باید مطابق روت سرور باشد
            await MultipartFile.fromFile(path),
          ),
        );
      }
    }

    return formData;
  }
}
