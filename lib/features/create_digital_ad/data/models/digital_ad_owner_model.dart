import '../../domain/entities/digital_ad_owner_entity.dart';

class DigitalAdOwnerModel extends DigitalAdOwnerEntity {
  const DigitalAdOwnerModel({
    required super.fullName,
    required super.phoneNumber,
    required super.province,
    required super.city,
  });

  factory DigitalAdOwnerModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdOwnerModel(
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      province: json['province'] ?? '',
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'province': province,
      'city': city,
    };
  }
}
