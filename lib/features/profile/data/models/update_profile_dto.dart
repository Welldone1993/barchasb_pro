// lib/features/profile/data/models/update_profile_dto.dart

class UpdateProfileDto {
  final UpdateUserDataDto user;
  final UpdateProfileDataDto profile;

  UpdateProfileDto({
    required this.user,
    required this.profile,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'profile': profile.toJson(),
    };
  }
}

class UpdateUserDataDto {
  final String? name;
  final String? lastName;
  final String? username;
  final String? phone;
  final String? email;
  final String? birthDate;
  final String? province;
  final String? city;

  UpdateUserDataDto({
    this.name,
    this.lastName,
    this.username,
    this.phone,
    this.email,
    this.birthDate,
    this.province,
    this.city,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (lastName != null) data['lastName'] = lastName;
    if (username != null) data['username'] = username;
    if (phone != null) data['phone'] = phone;
    if (email != null) data['email'] = email;
    if (birthDate != null) data['birthDate'] = birthDate;
    if (province != null) data['province'] = province;
    if (city != null) data['city'] = city;
    return data;
  }
}

class UpdateProfileDataDto {
  final String? address;
  final String? educationLevel;
  final String? aboutMe;
  final List<String>? interests;
  final List<String>? skills;
  final String? resumeFile;
  final List<String>? portfolioFiles;
  final List<ProfileDocumentDto>? documents;

  UpdateProfileDataDto({
    this.address,
    this.educationLevel,
    this.aboutMe,
    this.interests,
    this.skills,
    this.resumeFile,
    this.portfolioFiles,
    this.documents,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (address != null) data['address'] = address;
    if (educationLevel != null) data['educationLevel'] = educationLevel;
    if (aboutMe != null) data['aboutMe'] = aboutMe;
    if (interests != null) data['interests'] = interests;
    if (skills != null) data['skills'] = skills;
    if (resumeFile != null) data['resumeFile'] = resumeFile;
    if (portfolioFiles != null) data['portfolioFiles'] = portfolioFiles;
    if (documents != null) {
      data['documents'] = documents!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ProfileDocumentDto {
  final String title;
  final String file;

  ProfileDocumentDto({required this.title, required this.file});

  Map<String, dynamic> toJson() => {
    'title': title,
    'file': file,
  };

  factory ProfileDocumentDto.fromJson(Map<String, dynamic> json) {
    return ProfileDocumentDto(
      title: json['title'] ?? '',
      file: json['file'] ?? '',
    );
  }
}
