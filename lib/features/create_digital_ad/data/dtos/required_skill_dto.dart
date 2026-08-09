class RequiredSkillDto {
  final String name;

  const RequiredSkillDto({required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory RequiredSkillDto.fromJson(Map<String, dynamic> json) {
    return RequiredSkillDto(
      name: json['name'] ?? '',
    );
  }
}
