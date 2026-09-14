import 'package:equatable/equatable.dart';

class UserProfileDataEntity extends Equatable {
  final UserInfoEntity user;
  final ProfileDetailsEntity profile;

  const UserProfileDataEntity({
    required this.user,
    required this.profile,
  });

  @override
  List<Object?> get props => [user, profile];
}

class UserInfoEntity extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String? username;
  final String phone;
  final String? email;
  final String? birthDate;
  final String? province;
  final String? city;
  final String? nationalCode;
  final bool emailConfirmed;
  final bool phoneConfirmed;

  const UserInfoEntity({
    required this.id,
    required this.name,
    required this.lastName,
    this.username,
    required this.phone,
    this.email,
    this.birthDate,
    this.province,
    this.city,
    this.nationalCode,
    required this.emailConfirmed,
    required this.phoneConfirmed,
  });

  String get fullName => '$name $lastName'.trim();

  @override
  List<Object?> get props => [
    id,
    name,
    lastName,
    username,
    phone,
    email,
    birthDate,
    province,
    city,
    nationalCode,
    emailConfirmed,
    phoneConfirmed,
  ];
}

class DocumentItemEntity extends Equatable {
  final String title;
  final String file;

  const DocumentItemEntity({
    required this.title,
    required this.file,
  });

  @override
  List<Object?> get props => [title, file];
}

class ProfileDetailsEntity extends Equatable {
  final String id;
  final String? profileImage;
  final String? address;
  final String? educationLevel;
  final String? aboutMe;
  final List<String> interests;
  final List<String> skills;
  final String? resumeFile;
  final List<String> portfolioFiles;
  final List<DocumentItemEntity> documents;
  final bool completed;

  const ProfileDetailsEntity({
    required this.id,
    this.profileImage,
    this.address,
    this.educationLevel,
    this.aboutMe,
    this.interests = const [],
    this.skills = const [],
    this.resumeFile,
    this.portfolioFiles = const [],
    this.documents = const [],
    this.completed = false,
  });

  @override
  List<Object?> get props => [
    id,
    profileImage,
    address,
    educationLevel,
    aboutMe,
    interests,
    skills,
    resumeFile,
    portfolioFiles,
    documents,
    completed,
  ];
}
