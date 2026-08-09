import 'package:flutter_riverpod/legacy.dart';

// کلاس داده برای نگهداری اطلاعات استپ اول
class Step1Data {
  final String? imagePath;
  final String name;
  final String age;
  final String education;
  final String suggestedSalary;

  Step1Data({
    this.imagePath,
    this.name = '',
    this.age = '',
    this.education = '',
    this.suggestedSalary = '',
  });

  Step1Data copyWith({
    String? imagePath,
    String? name,
    String? age,
    String? education,
    String? suggestedSalary,
  }) {
    return Step1Data(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      age: age ?? this.age,
      education: education ?? this.education,
      suggestedSalary: suggestedSalary ?? this.suggestedSalary,
    );
  }
}

// StateNotifier برای مدیریت وضعیت فرم
class Step1Notifier extends StateNotifier<Step1Data> {
  Step1Notifier() : super(Step1Data());

  void setImage(String path) => state = state.copyWith(imagePath: path);
  void setName(String name) => state = state.copyWith(name: name);
  void setAge(String age) => state = state.copyWith(age: age);
  void setEducation(String education) => state = state.copyWith(education: education);
  void setSalary(String salary) => state = state.copyWith(suggestedSalary: salary);
}

// پروایدر سراسری
final step1Provider =
StateNotifierProvider<Step1Notifier, Step1Data>((ref) {
  return Step1Notifier();
});
