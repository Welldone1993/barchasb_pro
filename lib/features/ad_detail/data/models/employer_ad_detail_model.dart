import '../../domain/entities/ad_image_entity.dart';
import '../../domain/entities/employer_ad_category_entity.dart';
import '../../domain/entities/employer_ad_detail_entity.dart';
import '../../domain/entities/enhancement_entity.dart';
import '../../domain/entities/job_detail_entity.dart';
import '../../domain/entities/owner_entity.dart';
import '../../domain/entities/rating_entity.dart';

class EmployerAdDetailModel extends EmployerAdDetailEntity {
  const EmployerAdDetailModel({
    required super.id,
    super.owner,
    required super.images,
    required super.name,
    required super.title,
    required super.categories,
    required super.state,
    required super.city,
    required super.cooperationType,
    required super.gender,
    required super.militaryStatus,
    required super.experience,
    super.paymentMethod,
    required super.isRemote,
    required super.thursdayUntilNoon,
    required super.startTime,
    required super.endTime,
    required super.minSalary,
    required super.maxSalary,
    required super.companyName,
    required super.companyType,
    required super.benefits,
    required super.insurance,
    required super.education,
    required super.companyDescription,
    required super.jobDetails,
    required super.rating,
    required super.person,
    required super.isVerified,
    required super.enableChat,
    required super.enablePhone,
    required super.adPaymentMethod,
    required super.adStatus,
    super.createdAt,
    super.approvedAt,
    super.expiresAt,
    required super.isPaid,
    super.phoneOther,
    super.rejectionReason,
    super.approvedBy,
    super.rejectedBy,
    required super.enhancements,
  });

  factory EmployerAdDetailModel.fromJson(Map<String, dynamic> json) {
    return EmployerAdDetailModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      owner: json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null,
      images: json['images'] != null && json['images'] is List
          ? (json['images'] as List)
                .map((e) => AdImageModel.fromJson(e))
                .toList()
          : [],
      name: json['name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      categories: json['categories'] != null && json['categories'] is List
          ? (json['categories'] as List)
                .map((e) => EmployerAdCategoryModel.fromJson(e))
                .toList()
          : [],
      state: json['state']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      cooperationType: json['cooperationType']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      militaryStatus: json['militaryStatus']?.toString() ?? '',
      experience: json['experience']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString(),
      isRemote: json['isRemote'] ?? false,
      thursdayUntilNoon: json['thursdayUntilNoon'] ?? false,
      startTime: json['startTime']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? '',
      minSalary: json['minSalary']?.toString() ?? '',
      maxSalary: json['maxSalary']?.toString() ?? '',
      companyName: json['companyName']?.toString() ?? '',
      companyType: json['companyType']?.toString() ?? '',
      benefits: json['benefits']?.toString() ?? '',
      insurance: json['insurance']?.toString() ?? '',
      education: json['education']?.toString() ?? '',
      companyDescription: json['companyDescription']?.toString() ?? '',
      jobDetails: json['jobDetails'] != null && json['jobDetails'] is List
          ? (json['jobDetails'] as List)
                .map((e) => JobDetailModel.fromJson(e))
                .toList()
          : [],
      rating: json['rating'] != null
          ? RatingModel.fromJson(json['rating'])
          : const RatingModel(count: 0, average: 0),
      person: json['person']?.toString() ?? '',
      isVerified: json['isVerified'] ?? false,
      enableChat: json['enableChat'] ?? false,
      enablePhone: json['enablePhone'] ?? true,
      adPaymentMethod: json['adPaymentMethod']?.toString() ?? '',
      adStatus: json['adStatus']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      approvedAt: json['approvedAt'] != null
          ? DateTime.tryParse(json['approvedAt'])
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'])
          : null,
      isPaid: json['isPaid'] ?? false,
      phoneOther: json['phoneOther']?.toString(),
      rejectionReason: json['rejectionReason']?.toString(),
      approvedBy: json['approvedBy']?.toString(),
      rejectedBy: json['rejectedBy']?.toString(),
      enhancements: json['enhancements'] != null
          ? EnhancementsModel.fromJson(json['enhancements'])
          : const EnhancementsModel(
              isSpecial: false,
              isLadder: false,
              ladders: [],
              specialEndDate: null,
              specialStartDate: null,
            ),
    );
  }
}

class EmployerAdCategoryModel extends EmployerAdCategoryEntity {
  const EmployerAdCategoryModel({
    required super.name,
    required super.subCategories,
  });

  factory EmployerAdCategoryModel.fromJson(Map<String, dynamic> json) {
    return EmployerAdCategoryModel(
      name: json['name']?.toString() ?? '',
      subCategories:
          json['subCategories'] != null && json['subCategories'] is List
          ? List<String>.from(json['subCategories'].map((x) => x.toString()))
          : [],
    );
  }
}

class JobDetailModel extends JobDetailEntity {
  const JobDetailModel({required super.title, required super.description});

  factory JobDetailModel.fromJson(Map<String, dynamic> json) {
    return JobDetailModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}

class OwnerModel extends OwnerEntity {
  const OwnerModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) => OwnerModel(
    id: json['id'] ?? '',
    fullName: json['fullName'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
  );
}

class EnhancementsModel extends EnhancementsEntity {
  const EnhancementsModel({
    required super.isLadder,
    required super.ladders,
    required super.isSpecial,
    required super.specialEndDate,
    required super.specialStartDate,
  });

  factory EnhancementsModel.fromJson(Map<String, dynamic> json) {
    return EnhancementsModel(
      isSpecial: json['isSpecial'] ?? false,
      specialStartDate: json['specialStartDate'] != null
          ? DateTime.tryParse(json['specialStartDate'])
          : null,
      specialEndDate: json['specialEndDate'] != null
          ? DateTime.tryParse(json['specialEndDate'])
          : null,
      isLadder: json['isLadder'] ?? false,
      ladders: json['ladders'] != null && json['ladders'] is List
          ? json['ladders'] as List
          : [],
    );
  }
}

class AdImageModel extends AdImageEntity {
  const AdImageModel({required super.url, required super.isMain});

  factory AdImageModel.fromJson(Map<String, dynamic> json) {
    return AdImageModel(
      url: json['url']?.toString() ?? '',
      isMain: json['isMain'] == true,
    );
  }
}

class RatingModel extends RatingEntity {
  const RatingModel({required super.count, required super.average});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      count: (json['count'] as num?)?.toInt() ?? 0,
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
