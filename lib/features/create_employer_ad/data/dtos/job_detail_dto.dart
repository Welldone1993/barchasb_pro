class JobDetailDto {
  final String title;
  final String description;

  JobDetailDto({required this.title, required this.description});

  Map<String, dynamic> toJson() => {'title': title, 'description': description};
}
