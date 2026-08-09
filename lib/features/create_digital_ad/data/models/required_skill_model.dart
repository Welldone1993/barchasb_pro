import '../../domain/entities/required_skill_entity.dart';

class RequiredSkillModel extends RequiredSkillEntity {
  const RequiredSkillModel({
    required super.name,
  });

  factory RequiredSkillModel.fromJson(Map<String, dynamic> json) {
    return RequiredSkillModel(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
