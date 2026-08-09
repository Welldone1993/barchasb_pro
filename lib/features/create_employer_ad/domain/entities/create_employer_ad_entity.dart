import 'employer_ad_category_entity.dart';
import 'job_detail_entity.dart';

class CreateEmployerAdEntity {
  final String? name;
  final String? title;
  final List<String> images; // آدرس فایل‌های لوکال یا URL
  final List<EmployerAdCategoryEntity> categories;
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
  final double? minSalary;
  final double? maxSalary;
  final String? companyName;
  final String? companyType;
  final String? benefits;
  final bool? insurance;
  final String? education;
  final String? companyDescription;
  final List<JobDetailEntity> jobDetails;
  final String? person; // 'self' or 'other'
  final bool? isVerified;
  final bool? enableChat;
  final bool? enablePhone;

  CreateEmployerAdEntity({
    this.name,
    this.title,
    this.categories = const [],
    this.jobDetails = const [],
    this.images = const [],
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
}
