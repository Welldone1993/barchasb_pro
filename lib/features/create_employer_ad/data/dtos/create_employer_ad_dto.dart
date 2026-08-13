import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'employer_ad_category_dto.dart';
import 'job_detail_dto.dart';

class CreateEmployerAdRequestDto {
  final List<String> images; // مسیر (Path) عکس‌ها در فلاتر

  final String name;
  final String title;

  final List<EmployerAdCategoryDto>? categories;

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
  final String? minSalary;
  final String? maxSalary;

  final String? companyName;
  final String? companyType;
  final String? benefits;
  final String? insurance;
  final String? education;
  final String? companyDescription;

  final List<JobDetailDto>? jobDetails;

  final String? person;
  final bool? isVerified;
  final bool? enableChat;
  final bool? enablePhone;
  final String? adPaymentMethod;
  final String? adStatus;

  CreateEmployerAdRequestDto({
    required this.images,
    required this.name,
    required this.title,
    this.categories,
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
    this.jobDetails,
    this.person,
    this.isVerified,
    this.enableChat,
    this.enablePhone,
    this.adPaymentMethod,
    this.adStatus,
  });

  /// تبدیل تمام فیلدها به فرمت `FormData` برای ارسال در ریکوئست `multipart/form-data`
  Future<FormData> toFormData() async {
    Map<String, dynamic> formMap = {
      'name': name,
      'title': title,
    };

    // لیست آبجکت‌ها باید به صورت JSON String ارسال شوند
    if (categories != null && categories!.isNotEmpty) {
      formMap['categories'] = jsonEncode(categories!.map((e) => e.toJson()).toList());
    }
    if (jobDetails != null && jobDetails!.isNotEmpty) {
      formMap['jobDetails'] = jsonEncode(jobDetails!.map((e) => e.toJson()).toList());
    }

    // فیلدهای Optional (String و Bool)
    if (state != null) formMap['state'] = state;
    if (city != null) formMap['city'] = city;
    if (cooperationType != null) formMap['cooperationType'] = cooperationType;
    if (gender != null) formMap['gender'] = gender;
    if (militaryStatus != null) formMap['militaryStatus'] = militaryStatus;
    if (experience != null) formMap['experience'] = experience;
    if (paymentMethod != null) formMap['paymentMethod'] = paymentMethod;
    if (isRemote != null) formMap['isRemote'] = isRemote.toString();
    if (thursdayUntilNoon != null) formMap['thursdayUntilNoon'] = thursdayUntilNoon.toString();
    if (startTime != null) formMap['startTime'] = startTime;
    if (endTime != null) formMap['endTime'] = endTime;
    if (minSalary != null) formMap['minSalary'] = minSalary;
    if (maxSalary != null) formMap['maxSalary'] = maxSalary;

    if (companyName != null) formMap['companyName'] = companyName;
    if (companyType != null) formMap['companyType'] = companyType;
    if (benefits != null) formMap['benefits'] = benefits;
    if (insurance != null) formMap['insurance'] = insurance;
    if (education != null) formMap['education'] = education;
    if (companyDescription != null) formMap['companyDescription'] = companyDescription;

    if (person != null) formMap['person'] = person;
    if (isVerified != null) formMap['isVerified'] = isVerified.toString();
    if (enableChat != null) formMap['enableChat'] = enableChat.toString();
    if (enablePhone != null) formMap['enablePhone'] = enablePhone.toString();
    if (adPaymentMethod != null) formMap['adPaymentMethod'] = adPaymentMethod;
    if (adStatus != null) formMap['adStatus'] = adStatus;

    FormData formData = FormData.fromMap(formMap);

    // افزودن تصاویر به FormData
    if (images.isNotEmpty) {
      for (var imagePath in images) {
        formData.files.add(MapEntry(
          'images', // این کلید باید با نامی که بک‌اند انتظار دارد (images) دقیقا یکی باشد
          await MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split('/').last,
          ),
        ));
      }
    }

    return formData;
  }
}
