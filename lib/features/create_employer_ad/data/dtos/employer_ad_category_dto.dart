class EmployerAdCategoryDto {
  final String name;
  final List<String> subCategories;

  EmployerAdCategoryDto({required this.name, required this.subCategories});

  Map<String, dynamic> toJson() {
    return {'name': name, 'subCategories': subCategories};
  }
}
