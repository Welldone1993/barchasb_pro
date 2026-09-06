import '../../domain/entities/digital_ad_detail_entity.dart';

class DigitalAdDetailModel extends DigitalAdDetailEntity {
  const DigitalAdDetailModel({
    required super.id,
    super.ownerId,
    super.owner,
    required super.images,
    required super.title,
    required super.description,
    super.digitalTotalDesc,
    required super.projectNames,
    required super.projectDescriptions,
    super.minBudget,
    super.maxBudget,
    required super.requiredSkills,
    required super.person,
    required super.remote,
    required super.thursdayHalf,
    super.verifyCode,
    required super.paymentMethod,
    required super.adStatus,
    super.requestType,
    super.durationUnit,
    super.durationAmount,
    super.createdAt,
    super.approvedAt,
    super.expiresAt,
    required super.isPaid,
    super.province,
    super.city,
    super.phoneOther,
    required super.enhancements,
  });

  factory DigitalAdDetailModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdDetailModel(
      id: json['id']?.toString() ?? '',
      ownerId: json['owner'] is String ? json['owner'] : null,
      owner: json['owner'] != null && json['owner'] is Map<String, dynamic>
          ? DigitalAdOwnerModel.fromJson(json['owner'] as Map<String, dynamic>)
          : null,
      images: json['images'] != null && json['images'] is List
          ? (json['images'] as List)
          .map((e) => DigitalAdImageModel.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      digitalTotalDesc: json['digitalTotalDesc']?.toString(),
      projectNames: json['projectNames'] != null && json['projectNames'] is List
          ? List<String>.from((json['projectNames'] as List).map((x) => x.toString()))
          : [],
      projectDescriptions: json['projectDescriptions'] != null && json['projectDescriptions'] is List
          ? List<String>.from((json['projectDescriptions'] as List).map((x) => x.toString()))
          : [],
      minBudget: json['minBudget']?.toString(),
      maxBudget: json['maxBudget']?.toString(),
      requiredSkills: json['requiredSkills'] != null && json['requiredSkills'] is List
          ? (json['requiredSkills'] as List)
          .map((e) => DigitalSkillModel.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      person: json['person']?.toString() ?? 'self',
      remote: json['remote'] is bool ? json['remote'] : (json['remote']?.toString() == 'true'),
      thursdayHalf: json['thursdayHalf'] is bool ? json['thursdayHalf'] : (json['thursdayHalf']?.toString() == 'true'),
      verifyCode: json['verifyCode']?.toString(),
      paymentMethod: json['paymentMethod']?.toString() ?? 'Bank_card',
      adStatus: json['adStatus']?.toString() ?? 'pending',
      requestType: json['requestType']?.toString(),
      durationUnit: json['durationUnit']?.toString(),
      durationAmount: json['durationAmount']?.toString(),
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      approvedAt: json['approvedAt'] != null ? DateTime.tryParse(json['approvedAt'].toString()) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.tryParse(json['expiresAt'].toString()) : null,
      isPaid: json['isPaid'] is bool ? json['isPaid'] : true,
      province: json['province']?.toString(),
      city: json['city']?.toString(),
      phoneOther: json['phoneOther']?.toString(),
      enhancements: json['enhancements'] != null && json['enhancements'] is Map<String, dynamic>
          ? DigitalAdEnhancementsModel.fromJson(json['enhancements'] as Map<String, dynamic>)
          : const DigitalAdEnhancementsModel(
        isSpecial: false,
        isLadder: false,
        ladders: [],
      ),
    );
  }
}

class DigitalAdOwnerModel extends DigitalAdOwnerEntity {
  const DigitalAdOwnerModel({
    required super.fullName,
    required super.phoneNumber,
    super.province,
    super.city,
  });

  factory DigitalAdOwnerModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdOwnerModel(
      fullName: json['fullName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      province: json['province']?.toString(),
      city: json['city']?.toString(),
    );
  }
}

class DigitalAdImageModel extends DigitalAdImageEntity {
  const DigitalAdImageModel({
    required super.url,
    required super.isMain,
  });

  factory DigitalAdImageModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdImageModel(
      url: json['url']?.toString() ?? '',
      isMain: json['isMain'] is bool ? json['isMain'] : false,
    );
  }
}

class DigitalSkillModel extends DigitalSkillEntity {
  const DigitalSkillModel({
    required super.name,
  });

  factory DigitalSkillModel.fromJson(Map<String, dynamic> json) {
    return DigitalSkillModel(
      name: json['name']?.toString() ?? '',
    );
  }
}

class DigitalAdEnhancementsModel extends DigitalAdEnhancementsEntity {
  const DigitalAdEnhancementsModel({
    required super.isSpecial,
    super.specialStartDate,
    super.specialEndDate,
    required super.isLadder,
    required super.ladders,
  });

  factory DigitalAdEnhancementsModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdEnhancementsModel(
      isSpecial: json['isSpecial'] is bool ? json['isSpecial'] : false,
      specialStartDate: json['specialStartDate'] != null
          ? DateTime.tryParse(json['specialStartDate'].toString())
          : null,
      specialEndDate: json['specialEndDate'] != null
          ? DateTime.tryParse(json['specialEndDate'].toString())
          : null,
      isLadder: json['isLadder'] is bool ? json['isLadder'] : false,
      ladders: json['ladders'] is List ? (json['ladders'] as List) : [],
    );
  }
}
