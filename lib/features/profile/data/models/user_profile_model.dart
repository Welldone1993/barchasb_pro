
import '../../domain/entities/user_profile_entity.dart';

class UserProfileDataModel extends UserProfileDataEntity {
  const UserProfileDataModel({
    required super.user,
    required super.profile,
  });

  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDataModel(
      user: UserInfoModel.fromJson(json['user'] ?? {}),
      profile: ProfileDetailsModel.fromJson(json['profile'] ?? {}),
    );
  }
}

class UserInfoModel extends UserInfoEntity {
  const UserInfoModel({
    required super.id,
    required super.name,
    required super.lastName,
    super.username,
    required super.phone,
    super.email,
    super.birthDate,
    super.province,
    super.city,
    super.nationalCode,
    required super.emailConfirmed,
    required super.phoneConfirmed,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      username: json['username']?.toString(),
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString(),
      birthDate: json['birthDate']?.toString(),
      province: json['province']?.toString(),
      city: json['city']?.toString(),
      nationalCode: json['nationalCode']?.toString(),
      emailConfirmed: json['email_confirmed'] == true,
      phoneConfirmed: json['phone_confirmed'] == true,
    );
  }
}

class DocumentItemModel extends DocumentItemEntity {
  const DocumentItemModel({
    required super.title,
    required super.file,
  });

  factory DocumentItemModel.fromJson(Map<String, dynamic> json) {
    return DocumentItemModel(
      title: json['title']?.toString() ?? '',
      file: json['file']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'file': file,
  };
}

class ProfileDetailsModel extends ProfileDetailsEntity {
  const ProfileDetailsModel({
    required super.id,
    super.profileImage,
    super.address,
    super.educationLevel,
    super.aboutMe,
    super.interests,
    super.skills,
    super.resumeFile,
    super.portfolioFiles,
    super.documents,
    super.completed,
  });

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsModel(
      id: json['id']?.toString() ?? '',
      profileImage: json['profileImage']?.toString(),
      address: json['address']?.toString(),
      educationLevel: json['educationLevel']?.toString(),
      aboutMe: json['aboutMe']?.toString(),
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      resumeFile: json['resumeFile']?.toString(),
      portfolioFiles: (json['portfolioFiles'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => DocumentItemModel.fromJson(e is Map<String, dynamic> ? e : {}))
          .toList() ??
          [],
      completed: json['completed'] == true,
    );
  }
}
