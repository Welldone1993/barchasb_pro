// create_job_seeker_ad_request_dto.dart

import 'dart:convert';
import 'package:dio/dio.dart';

class CreateJobSeekerAdRequestDto {
  final String? name;
  final int? age;
  final String? gender;
  final String? phoneNumber;
  final String? state;
  final String? city;
  final String? category;
  final List<String>? skills;
  final num? suggestedSalaryIRT;
  final String? aboutMe;
  final List<String>? images; // مسیر فایل‌های تصاویر در گوشی

  CreateJobSeekerAdRequestDto({
    this.name,
    this.age,
    this.gender,
    this.phoneNumber,
    this.state,
    this.city,
    this.category,
    this.skills,
    this.suggestedSalaryIRT,
    this.aboutMe,
    this.images,
  });

  /// تبدیل داده‌ها به FormData برای ارسال با Dio
  Future<FormData> toFormData() async {
    final formData = FormData();

    if (name != null) formData.fields.add(MapEntry('name', name!));
    if (age != null) formData.fields.add(MapEntry('age', age.toString()));
    if (gender != null) formData.fields.add(MapEntry('gender', gender!));
    if (phoneNumber != null) formData.fields.add(MapEntry('phoneNumber', phoneNumber!));
    if (state != null) formData.fields.add(MapEntry('state', state!));
    if (city != null) formData.fields.add(MapEntry('city', city!));
    if (category != null) formData.fields.add(MapEntry('category', category!));
    if (suggestedSalaryIRT != null) {
      formData.fields.add(MapEntry('suggestedSalaryIRT', suggestedSalaryIRT.toString()));
    }
    if (aboutMe != null) formData.fields.add(MapEntry('aboutMe', aboutMe!));

    // مدیریت آرایه مهارت‌ها (Skills)
    // بسته به پیاده‌سازی بک‌اند، آرایه‌ها معمولاً یا به شکل JSON string ارسال می‌شوند
    // و یا با کلیدهای یکسان (مثلاً skills[0], skills[1])
    if (skills != null && skills!.isNotEmpty) {
      // روش اول: ارسال به عنوان JSON String (رایج‌ترین حالت در این معماری)
      formData.fields.add(MapEntry('skills', jsonEncode(skills)));

      // روش دوم (اگر بک‌اند روش بالا را نخواند، این خطوط را جایگزین کنید):
      // for (var skill in skills!) {
      //   formData.fields.add(MapEntry('skills[]', skill));
      // }
    }

    // مدیریت تصاویر (حداکثر ۹ تصویر طبق لاجیک بک‌اند)
    if (images != null && images!.isNotEmpty) {
      for (var imagePath in images!) {
        formData.files.add(
          MapEntry(
            'images', // این نام باید دقیقاً با فیلد Multer در بک‌اند یکی باشد
            await MultipartFile.fromFile(imagePath),
          ),
        );
      }
    }

    return formData;
  }
}
