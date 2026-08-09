class EmployerAdCategoryDto {
  final String name;
  final List<String> subCategories;

  EmployerAdCategoryDto({
    required this.name,
    required this.subCategories,
    required int categoryId,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'subCategories': subCategories,
  };
}
