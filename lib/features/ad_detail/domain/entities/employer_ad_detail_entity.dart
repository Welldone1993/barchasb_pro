import 'ad_image_entity.dart';
import 'employer_ad_category_entity.dart';
import 'enhancement_entity.dart';
import 'job_detail_entity.dart';
import 'owner_entity.dart';
import 'rating_entity.dart';

class EmployerAdDetailEntity {
  final String id;
  final OwnerEntity? owner;
  final List<AdImageEntity> images;
  final String name;
  final String title;
  final List<EmployerAdCategoryEntity> categories;
  final String state;
  final String city;
  final String cooperationType;
  final String gender;
  final String militaryStatus;
  final String experience;
  final String? paymentMethod;
  final bool isRemote;
  final bool thursdayUntilNoon;
  final String startTime;
  final String endTime;
  final String minSalary;
  final String maxSalary;
  final String companyName;
  final String companyType;
  final String benefits;
  final String insurance;
  final String education;
  final String companyDescription;
  final List<JobDetailEntity> jobDetails;
  final RatingEntity rating;
  final String person;
  final bool isVerified;
  final bool enableChat;
  final bool enablePhone;
  final String adPaymentMethod;
  final String adStatus;
  final DateTime? createdAt;
  final DateTime? approvedAt;
  final DateTime? expiresAt;
  final bool isPaid;
  final String? phoneOther;
  final String? rejectionReason;
  final String? approvedBy;
  final String? rejectedBy;
  final EnhancementsEntity enhancements;

  const EmployerAdDetailEntity({
    required this.id,
    this.owner,
    required this.images,
    required this.name,
    required this.title,
    required this.categories,
    required this.state,
    required this.city,
    required this.cooperationType,
    required this.gender,
    required this.militaryStatus,
    required this.experience,
    this.paymentMethod,
    required this.isRemote,
    required this.thursdayUntilNoon,
    required this.startTime,
    required this.endTime,
    required this.minSalary,
    required this.maxSalary,
    required this.companyName,
    required this.companyType,
    required this.benefits,
    required this.insurance,
    required this.education,
    required this.companyDescription,
    required this.jobDetails,
    required this.rating,
    required this.person,
    required this.isVerified,
    required this.enableChat,
    required this.enablePhone,
    required this.adPaymentMethod,
    required this.adStatus,
    this.createdAt,
    this.approvedAt,
    this.expiresAt,
    required this.isPaid,
    this.phoneOther,
    this.rejectionReason,
    this.approvedBy,
    this.rejectedBy,
    required this.enhancements,
  });
}
