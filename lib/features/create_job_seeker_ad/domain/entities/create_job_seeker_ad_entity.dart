// job_seeker_ad_entity.dart

class CreateJobSeekerAdEntity {
  final String name;
  final int age;
  final String gender;
  final String phoneNumber;
  final String state;
  final String city;
  final String category;
  final List<String> skills;
  final num suggestedSalaryIRT;
  final String aboutMe;
  final List<String> imagePaths;

  CreateJobSeekerAdEntity({
    required this.name,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.category,
    required this.skills,
    required this.suggestedSalaryIRT,
    required this.aboutMe,
    this.imagePaths = const [],
  });
}
