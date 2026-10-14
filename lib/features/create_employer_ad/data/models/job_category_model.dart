import '../../domain/entities/job_category_entity.dart';

class JobCategoryModel extends JobCategoryEntity {
  JobCategoryModel({required super.id, required super.name});

  factory JobCategoryModel.fromJson(Map<String, dynamic> json) {
    return JobCategoryModel(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: (json['name'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobCategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
