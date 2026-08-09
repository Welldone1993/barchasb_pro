import 'package:flutter_riverpod/legacy.dart';

// مدل سابقه شغلی
class WorkExperience {
  final String title;
  final String description;

  WorkExperience({required this.title, required this.description});
}

// کلاس داده استپ ۲
class Step2Data {
  final String minSalary;
  final String maxSalary; // بر اساس تصویر، دو فیلد حقوق وجود دارد
  final String? resumePath;
  final String? portfolioPath;
  final String phoneNumber;
  final String province;
  final String city;

  // داده‌های سایر مشخصات
  final String maritalStatus;
  final String gender;
  final String militaryStatus;
  final String instagram;
  final String linkedin;
  final String github;
  final String aboutMe;

  // لیست سوابق شغلی
  final List<WorkExperience> workExperiences;

  Step2Data({
    this.minSalary = '',
    this.maxSalary = '',
    this.resumePath,
    this.portfolioPath,
    this.phoneNumber = '',
    this.province = '',
    this.city = '',
    this.maritalStatus = '',
    this.gender = '',
    this.militaryStatus = '',
    this.instagram = '',
    this.linkedin = '',
    this.github = '',
    this.aboutMe = '',
    this.workExperiences = const [],
  });

  Step2Data copyWith({
    String? minSalary,
    String? maxSalary,
    String? resumePath,
    String? portfolioPath,
    String? phoneNumber,
    String? province,
    String? city,
    String? maritalStatus,
    String? gender,
    String? militaryStatus,
    String? instagram,
    String? linkedin,
    String? github,
    String? aboutMe,
    List<WorkExperience>? workExperiences,
  }) {
    return Step2Data(
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      resumePath: resumePath ?? this.resumePath,
      portfolioPath: portfolioPath ?? this.portfolioPath,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      province: province ?? this.province,
      city: city ?? this.city,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      gender: gender ?? this.gender,
      militaryStatus: militaryStatus ?? this.militaryStatus,
      instagram: instagram ?? this.instagram,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      aboutMe: aboutMe ?? this.aboutMe,
      workExperiences: workExperiences ?? this.workExperiences,
    );
  }
}

// StateNotifier
class Step2Notifier extends StateNotifier<Step2Data> {
  Step2Notifier() : super(Step2Data());

  void setMinSalary(String value) => state = state.copyWith(minSalary: value);

  void setMaxSalary(String value) => state = state.copyWith(maxSalary: value);

  void setResumePath(String? path) => state = state.copyWith(resumePath: path);

  void setPortfolioPath(String? path) =>
      state = state.copyWith(portfolioPath: path);

  void setPhoneNumber(String value) =>
      state = state.copyWith(phoneNumber: value);

  void setProvince(String value) => state = state.copyWith(province: value);

  void setCity(String value) => state = state.copyWith(city: value);

  void updateOtherSpecs({
    String? marital,
    String? gender,
    String? military,
    String? insta,
    String? linked,
    String? git,
  }) {
    state = state.copyWith(
      maritalStatus: marital ?? state.maritalStatus,
      gender: gender ?? state.gender,
      militaryStatus: military ?? state.militaryStatus,
      instagram: insta ?? state.instagram,
      linkedin: linked ?? state.linkedin,
      github: git ?? state.github,
    );
  }

  void addWorkExperience(WorkExperience exp) {
    state = state.copyWith(workExperiences: [...state.workExperiences, exp]);
  }

  void removeWorkExperience(int index) {
    final newList = List<WorkExperience>.from(state.workExperiences);
    newList.removeAt(index);
    state = state.copyWith(workExperiences: newList);
  }

  void setAboutMe(String value) => state = state.copyWith(aboutMe: value);
}

final step2Provider = StateNotifierProvider<Step2Notifier, Step2Data>((ref) {
  return Step2Notifier();
});
