import '../../domain/entities/digital_ad_enhancements_entity.dart';

class DigitalAdEnhancementsModel extends DigitalAdEnhancementsEntity {
  const DigitalAdEnhancementsModel({
    required super.isSpecial,
    required super.specialStartDate,
    required super.specialEndDate,
    required super.isLadder,
    required super.ladders,
  });

  factory DigitalAdEnhancementsModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdEnhancementsModel(
      isSpecial: json['isSpecial'] ?? false,
      specialStartDate: json['specialStartDate'] != null
          ? DateTime.tryParse(json['specialStartDate'].toString())
          : null,
      specialEndDate: json['specialEndDate'] != null
          ? DateTime.tryParse(json['specialEndDate'].toString())
          : null,
      isLadder: json['isLadder'] ?? false,
      ladders: (json['ladders'] as List?) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSpecial': isSpecial,
      'specialStartDate': specialStartDate?.toIso8601String(),
      'specialEndDate': specialEndDate?.toIso8601String(),
      'isLadder': isLadder,
      'ladders': ladders,
    };
  }
}
