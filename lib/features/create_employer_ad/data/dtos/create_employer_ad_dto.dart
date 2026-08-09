import 'dart:convert';
import 'package:dio/dio.dart';

import 'employer_ad_category_dto.dart';
import 'job_detail_dto.dart';

class CreateEmployerAdRequestDto {
  final String name;
  final String title;
  final List<String> images; // مسیر فایل‌های گوشی
  final List<EmployerAdCategoryDto> categories;
  final String? state;
  final String? city;
  final String? cooperationType;
  final String? gender;
  final String? militaryStatus;
  final String? experience;
  final String? paymentMethod;
  final bool? isRemote;
  final bool? thursdayUntilNoon;
  final String? startTime;
  final String? endTime;
  final num? minSalary;
  final num? maxSalary;
  final String? companyName;
  final String? companyType;
  final String? benefits;
  final bool? insurance;
  final String? education;
  final String? companyDescription;
  final List<JobDetailDto> jobDetails;
  final String? person;
  final bool? isVerified;
  final bool? enableChat;
  final bool? enablePhone;

  CreateEmployerAdRequestDto({
    required this.name,
    required this.title,
    required this.images,
    required this.categories,
    required this.jobDetails,
    this.state,
    this.city,
    this.cooperationType,
    this.gender,
    this.militaryStatus,
    this.experience,
    this.paymentMethod,
    this.isRemote,
    this.thursdayUntilNoon,
    this.startTime,
    this.endTime,
    this.minSalary,
    this.maxSalary,
    this.companyName,
    this.companyType,
    this.benefits,
    this.insurance,
    this.education,
    this.companyDescription,
    this.person,
    this.isVerified,
    this.enableChat,
    this.enablePhone,
  });

  /// تبدیل مدل به FormData برای ارسال به بک‌اند از طریق Dio
  Future<FormData> toFormData() async {
    final Map<String, dynamic> mapData = {
      'name': name,
      'title': title,

      // در فرم‌دیتا مقادیر پیچیده مثل لیست کلاس‌ها باید استرینگ (JSON) شوند
      'categories': jsonEncode(categories.map((e) => e.toJson()).toList()),
      'jobDetails': jsonEncode(jobDetails.map((e) => e.toJson()).toList()),

      if (state != null) 'state': state,
      if (city != null) 'city': city,
      if (cooperationType != null) 'cooperationType': cooperationType,
      if (gender != null) 'gender': gender,
      if (militaryStatus != null) 'militaryStatus': militaryStatus,
      if (experience != null) 'experience': experience,
      if (paymentMethod != null) 'paymentMethod': paymentMethod,

      // بولین‌ها در FormData بک‌اند nodejs معمولا به صورت استرینگ مدیریت می‌شوند
      if (isRemote != null) 'isRemote': isRemote.toString(),
      if (thursdayUntilNoon != null)
        'thursdayUntilNoon': thursdayUntilNoon.toString(),
      if (insurance != null) 'insurance': insurance.toString(),
      if (isVerified != null) 'isVerified': isVerified.toString(),
      if (enableChat != null) 'enableChat': enableChat.toString(),
      if (enablePhone != null) 'enablePhone': enablePhone.toString(),

      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (minSalary != null) 'minSalary': minSalary.toString(),
      if (maxSalary != null) 'maxSalary': maxSalary.toString(),
      if (companyName != null) 'companyName': companyName,
      if (companyType != null) 'companyType': companyType,
      if (benefits != null) 'benefits': benefits,
      if (education != null) 'education': education,
      if (companyDescription != null) 'companyDescription': companyDescription,
      if (person != null) 'person': person,
    };

    final formData = FormData.fromMap(mapData);

    // افزودن تصاویر به FormData
    for (var imagePath in images) {
      formData.files.add(
        MapEntry(
          'images',
          // این کلید دقیقاً باید با نامی که در بک‌انده (images) مچ باشد
          await MultipartFile.fromFile(imagePath),
        ),
      );
    }

    return formData;
  }
}
