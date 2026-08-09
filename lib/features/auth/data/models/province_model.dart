import 'package:barchasb/features/auth/domain/entities/province_entity.dart';

class ProvinceModel extends ProvinceEntity {
  ProvinceModel({
    required super.id,
    required super.name,
    required super.cities,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      cities: List<String>.from(json['cities'] ?? ''),
    );
  }
}
