import '../../domain/entities/job_seeker_ad_detail_entity.dart';

class JobSeekerAdDetailModel extends JobSeekerAdDetailEntity {
  const JobSeekerAdDetailModel({
    required super.id,
    super.owner,
    super.images,
    required super.name,
    required super.age,
    required super.gender,
    required super.maritalStatus,
    required super.militaryStatus,
    required super.phoneNumber,
    required super.state,
    required super.city,
    required super.category,
    super.resumeFile,
    super.workSampleFile,
    required super.education,
    super.skills,
    required super.suggestedSalaryIRT,
    required super.aboutMe,
    required super.instagram,
    required super.linkedIn,
    required super.gitHub,
    super.careerHistory,
    required super.rating,
    required super.person,
    required super.isVerified,
    required super.enableChat,
    required super.enablePhone,
    required super.paymentMethod,
    required super.adStatus,
    required super.userDesc,
    super.createdAt,
    super.approvedAt,
    super.expiresAt,
    required super.isPaid,
    super.enhancements,
  });

  factory JobSeekerAdDetailModel.fromJson(Map<String, dynamic> json) {
    return JobSeekerAdDetailModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      owner: json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => AdImageModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      name: json['name']?.toString() ?? '',
      age: json['age']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      maritalStatus: json['maritalStatus']?.toString() ?? '',
      militaryStatus: json['militaryStatus']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      resumeFile: json['resumeFile']?.toString(),
      workSampleFile: json['workSampleFile']?.toString(),
      education: json['education']?.toString() ?? '',
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      suggestedSalaryIRT: json['suggestedSalaryIRT']?.toString() ?? '',
      aboutMe: json['aboutMe']?.toString() ?? '',
      instagram: json['instagram']?.toString() ?? '',
      linkedIn: json['linkedIn']?.toString() ?? '',
      gitHub: json['gitHub']?.toString() ?? '',
      careerHistory: (json['careerHistory'] as List<dynamic>?)
          ?.map((e) => CareerHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      rating: json['rating'] != null
          ? RatingModel.fromJson(json['rating'])
          : const RatingModel(count: 0, average: 0),
      person: json['person']?.toString() ?? 'self',
      isVerified: json['isVerified'] == true,
      enableChat: json['enableChat'] == true,
      enablePhone: json['enablePhone'] == true,
      paymentMethod: json['paymentMethod']?.toString() ?? 'Bank_card',
      adStatus: json['adStatus']?.toString() ?? 'pending',
      userDesc: json['userDesc']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      approvedAt: json['approvedAt'] != null
          ? DateTime.tryParse(json['approvedAt'])
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'])
          : null,
      isPaid: json['isPaid'] == true,
      enhancements: json['enhancements'] != null
          ? EnhancementsModel.fromJson(json['enhancements'])
          : null,
    );
  }
}

class OwnerModel extends OwnerEntity {
  const OwnerModel({super.id, required super.fullName, required super.phoneNumber});

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id']?.toString() ?? json['_id']?.toString(),
      fullName: json['fullName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
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

class CareerHistoryModel extends CareerHistoryEntity {
  const CareerHistoryModel({required super.title, required super.description});

  factory CareerHistoryModel.fromJson(Map<String, dynamic> json) {
    return CareerHistoryModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}

class EnhancementsModel extends EnhancementsEntity {
  const EnhancementsModel({
    required super.isSpecial,
    super.specialStartDate,
    super.specialEndDate,
    required super.isLadder,
    super.ladders,
  });

  factory EnhancementsModel.fromJson(Map<String, dynamic> json) {
    return EnhancementsModel(
      isSpecial: json['isSpecial'] == true,
      specialStartDate: json['specialStartDate'] != null
          ? DateTime.tryParse(json['specialStartDate'])
          : null,
      specialEndDate: json['specialEndDate'] != null
          ? DateTime.tryParse(json['specialEndDate'])
          : null,
      isLadder: json['isLadder'] == true,
      ladders: json['ladders'] as List<dynamic>? ?? [],
    );
  }
}
