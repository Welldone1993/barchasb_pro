class DigitalAdDetailEntity {
  final String id;
  final String? ownerId;
  final DigitalAdOwnerEntity? owner;
  final List<DigitalAdImageEntity> images;
  final String title;
  final String description;
  final String? digitalTotalDesc;
  final List<String> projectNames;
  final List<String> projectDescriptions;
  final String? minBudget;
  final String? maxBudget;
  final List<DigitalSkillEntity> requiredSkills;
  final String person;
  final bool remote;
  final bool thursdayHalf;
  final String? verifyCode;
  final String paymentMethod;
  final String adStatus;
  final String? requestType;
  final String? durationUnit;
  final String? durationAmount;
  final DateTime? createdAt;
  final DateTime? approvedAt;
  final DateTime? expiresAt;
  final bool isPaid;
  final String? province;
  final String? city;
  final String? phoneOther;
  final DigitalAdEnhancementsEntity enhancements;

  const DigitalAdDetailEntity({
    required this.id,
    this.ownerId,
    this.owner,
    required this.images,
    required this.title,
    required this.description,
    this.digitalTotalDesc,
    required this.projectNames,
    required this.projectDescriptions,
    this.minBudget,
    this.maxBudget,
    required this.requiredSkills,
    required this.person,
    required this.remote,
    required this.thursdayHalf,
    this.verifyCode,
    required this.paymentMethod,
    required this.adStatus,
    this.requestType,
    this.durationUnit,
    this.durationAmount,
    this.createdAt,
    this.approvedAt,
    this.expiresAt,
    required this.isPaid,
    this.province,
    this.city,
    this.phoneOther,
    required this.enhancements,
  });
}

class DigitalAdOwnerEntity {
  final String fullName;
  final String phoneNumber;
  final String? province;
  final String? city;

  const DigitalAdOwnerEntity({
    required this.fullName,
    required this.phoneNumber,
    this.province,
    this.city,
  });
}

class DigitalAdImageEntity {
  final String url;
  final bool isMain;

  const DigitalAdImageEntity({
    required this.url,
    required this.isMain,
  });
}

class DigitalSkillEntity {
  final String name;

  const DigitalSkillEntity({
    required this.name,
  });
}

class DigitalAdEnhancementsEntity {
  final bool isSpecial;
  final DateTime? specialStartDate;
  final DateTime? specialEndDate;
  final bool isLadder;
  final List<dynamic> ladders;

  const DigitalAdEnhancementsEntity({
    required this.isSpecial,
    this.specialStartDate,
    this.specialEndDate,
    required this.isLadder,
    required this.ladders,
  });
}
