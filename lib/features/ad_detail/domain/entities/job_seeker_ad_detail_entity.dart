class JobSeekerAdDetailEntity {
  final String id;
  final OwnerEntity? owner;
  final List<AdImageEntity> images;
  final String name;
  final String age;
  final String gender;
  final String maritalStatus;
  final String militaryStatus;
  final String phoneNumber;
  final String state;
  final String city;
  final String category;
  final String? resumeFile;
  final String? workSampleFile;
  final String education;
  final List<String> skills;
  final String suggestedSalaryIRT;
  final String aboutMe;
  final String instagram;
  final String linkedIn;
  final String gitHub;
  final List<CareerHistoryEntity> careerHistory;
  final RatingEntity rating;
  final String person;
  final bool isVerified;
  final bool enableChat;
  final bool enablePhone;
  final String paymentMethod;
  final String adStatus;
  final String userDesc;
  final DateTime? createdAt;
  final DateTime? approvedAt;
  final DateTime? expiresAt;
  final bool isPaid;
  final EnhancementsEntity? enhancements;

  const JobSeekerAdDetailEntity({
    required this.id,
    this.owner,
    this.images = const [],
    required this.name,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.militaryStatus,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.category,
    this.resumeFile,
    this.workSampleFile,
    required this.education,
    this.skills = const [],
    required this.suggestedSalaryIRT,
    required this.aboutMe,
    required this.instagram,
    required this.linkedIn,
    required this.gitHub,
    this.careerHistory = const [],
    required this.rating,
    required this.person,
    required this.isVerified,
    required this.enableChat,
    required this.enablePhone,
    required this.paymentMethod,
    required this.adStatus,
    required this.userDesc,
    this.createdAt,
    this.approvedAt,
    this.expiresAt,
    required this.isPaid,
    this.enhancements,
  });
}

class OwnerEntity {
  final String? id;
  final String fullName;
  final String phoneNumber;

  const OwnerEntity({
    this.id,
    required this.fullName,
    required this.phoneNumber,
  });
}

class AdImageEntity {
  final String url;
  final bool isMain;

  const AdImageEntity({required this.url, required this.isMain});
}

class RatingEntity {
  final int count;
  final double average;

  const RatingEntity({required this.count, required this.average});
}

class CareerHistoryEntity {
  final String title;
  final String description;

  const CareerHistoryEntity({required this.title, required this.description});
}

class EnhancementsEntity {
  final bool isSpecial;
  final DateTime? specialStartDate;
  final DateTime? specialEndDate;
  final bool isLadder;
  final List<dynamic> ladders;

  const EnhancementsEntity({
    required this.isSpecial,
    this.specialStartDate,
    this.specialEndDate,
    required this.isLadder,
    this.ladders = const [],
  });
}
