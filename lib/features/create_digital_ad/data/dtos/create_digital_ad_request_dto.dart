import 'dart:convert';
import 'package:dio/dio.dart';
import 'required_skill_dto.dart';

class CreateDigitalAdRequestDto {
  final String? owner;
  final String? title;
  final String? description;
  final String? digitalTotalDesc;
  final List<String>? projectNames;
  final List<String>? projectDescriptions;
  final String? minBudget;
  final String? maxBudget;
  final List<RequiredSkillDto>? requiredSkills;
  final String? person; // self | other
  final bool? remote;
  final bool? thursdayHalf;
  final String? paymentMethod; // Subscription | Wallet | Bank_card
  final String? verifyCode;
  final String? adStatus;
  final String? requestType;
  final String? durationUnit;
  final int? durationAmount;

  // فیلدهای جا افتاده طبق Swagger
  final String? province;
  final String? city;
  final String? phoneOther;

  final DateTime? approvedAt;
  final DateTime? expiresAt;

  // مسیر عکس‌ها یا فایل‌ها
  final List<dynamic>? images;

  const CreateDigitalAdRequestDto({
    this.owner,
    this.title,
    this.description,
    this.digitalTotalDesc,
    this.projectNames,
    this.projectDescriptions,
    this.minBudget,
    this.maxBudget,
    this.requiredSkills,
    this.person,
    this.remote,
    this.thursdayHalf,
    this.paymentMethod,
    this.verifyCode,
    this.adStatus,
    this.requestType,
    this.durationUnit,
    this.durationAmount,
    this.province,
    this.city,
    this.phoneOther,
    this.approvedAt,
    this.expiresAt,
    this.images,
  });

  /// این متد مخصوص ساخت FormData برای ارسال به سرور است
  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = {};

    // متد کمکی برای اضافه کردن مقادیر غیر Null به عنوان String
    void addIfNotNull(String key, dynamic value) {
      if (value != null && value.toString().isNotEmpty) {
        data[key] = value.toString();
      }
    }

    addIfNotNull('owner', owner);
    addIfNotNull('title', title);
    addIfNotNull('description', description);
    addIfNotNull('digitalTotalDesc', digitalTotalDesc);
    addIfNotNull('minBudget', minBudget);
    addIfNotNull('maxBudget', maxBudget);
    addIfNotNull('person', person);
    addIfNotNull('paymentMethod', paymentMethod);
    addIfNotNull('verifyCode', verifyCode);
    addIfNotNull('adStatus', adStatus);
    addIfNotNull('requestType', requestType);
    addIfNotNull('durationUnit', durationUnit);
    addIfNotNull('durationAmount', durationAmount);

    // فیلدهای جدید
    addIfNotNull('province', province);
    addIfNotNull('city', city);
    addIfNotNull('phoneOther', phoneOther);

    // تبدیل بولین‌ها به String ("true" یا "false")
    if (remote != null) data['remote'] = remote.toString();
    if (thursdayHalf != null) data['thursdayHalf'] = thursdayHalf.toString();

    // تبدیل آرایه‌ها به رشته JSON طبق داکیومنت Swagger
    if (projectNames != null && projectNames!.isNotEmpty) {
      data['projectNames'] = jsonEncode(projectNames);
    }
    if (projectDescriptions != null && projectDescriptions!.isNotEmpty) {
      data['projectDescriptions'] = jsonEncode(projectDescriptions);
    }
    if (requiredSkills != null && requiredSkills!.isNotEmpty) {
      data['requiredSkills'] = jsonEncode(requiredSkills!.map((e) => e.toJson()).toList());
    }

    if (approvedAt != null) data['approvedAt'] = approvedAt!.toIso8601String();
    if (expiresAt != null) data['expiresAt'] = expiresAt!.toIso8601String();

    // ساخت FormData از دیتاهای متنی
    final formData = FormData.fromMap(data);

    // اضافه کردن تصاویر (تبدیل مسیر فایل به MultipartFile)
    if (images != null && images!.isNotEmpty) {
      for (var img in images!) {
        if (img is String) {
          // اگر لیست شما حاوی مسیر فایل‌های String است
          formData.files.add(
            MapEntry('images', await MultipartFile.fromFile(img)),
          );
        }
        // اگر نوع عکس‌ها XFile یا File (از dart:io) است، متد مناسب را فراخوانی کنید
        // مثال برای فایل جاوااسکریپتی/آیو :
        // if (img is File) formData.files.add(MapEntry('images', await MultipartFile.fromFile(img.path)));
      }
    }

    return formData;
  }
}
