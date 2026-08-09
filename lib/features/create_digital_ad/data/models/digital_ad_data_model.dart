import '../../domain/entities/digital_ad_entity.dart';
import 'digital_ad_enhancements_model.dart';
import 'digital_ad_image_model.dart';
import 'digital_ad_owner_model.dart';
import 'required_skill_model.dart';

class DigitalAdModel extends DigitalAdEntity {
  const DigitalAdModel({
    required super.id,
    super.ownerId,
    super.title,
    super.description,
    super.digitalTotalDesc,
    super.projectNames,
    super.projectDescriptions,
    super.minBudget,
    super.maxBudget,
    super.requiredSkills,
    required super.person,
    required super.remote,
    required super.thursdayHalf,
    required super.paymentMethod,
    super.adStatus,
    super.requestType,
    super.durationUnit,
    super.durationAmount,
    super.images,
    super.approvedAt,
    super.expiresAt,
    super.createdAt,
    super.updatedAt,
    super.owner,
    super.enhancements,
  });

  factory DigitalAdModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdModel(
      id: json['id']?.toString() ?? '',
      ownerId: json['owner'] is String
          ? json['owner']
          : json['owner']?['id']?.toString(),
      title: json['title'],
      description: json['description'],
      digitalTotalDesc: json['digitalTotalDesc'],
      projectNames:
          (json['projectNames'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      projectDescriptions:
          (json['projectDescriptions'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      minBudget: json['minBudget']?.toString(),
      maxBudget: json['maxBudget']?.toString(),
      requiredSkills:
          (json['requiredSkills'] as List?)
              ?.map(
                (e) =>
                    RequiredSkillModel.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList() ??
          [],
      person: json['person'] ?? 'self',
      remote: json['remote'] ?? false,
      thursdayHalf: json['thursdayHalf'] ?? false,
      paymentMethod: json['paymentMethod'] ?? 'Subscription',
      adStatus: json['adStatus'],
      requestType: json['requestType'],
      durationUnit: json['durationUnit'],
      durationAmount: json['durationAmount'] is int
          ? json['durationAmount']
          : int.tryParse(json['durationAmount']?.toString() ?? ''),
      images:
          (json['images'] as List?)
              ?.map(
                (e) =>
                    DigitalAdImageModel.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList() ??
          [],
      approvedAt: json['approvedAt'] != null
          ? DateTime.tryParse(json['approvedAt'].toString())
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'].toString())
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      owner: json['owner'] is Map<String, dynamic>
          ? DigitalAdOwnerModel.fromJson(
              Map<String, dynamic>.from(json['owner']),
            )
          : null,
      enhancements: json['enhancements'] is Map<String, dynamic>
          ? DigitalAdEnhancementsModel.fromJson(
              Map<String, dynamic>.from(json['enhancements']),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'digitalTotalDesc': digitalTotalDesc,
      'projectNames': projectNames,
      'projectDescriptions': projectDescriptions,
      'minBudget': minBudget,
      'maxBudget': maxBudget,
      'requiredSkills': requiredSkills
          .map((e) => (e as RequiredSkillModel).toJson())
          .toList(),
      'person': person,
      'remote': remote,
      'thursdayHalf': thursdayHalf,
      'paymentMethod': paymentMethod,
      'adStatus': adStatus,
      'requestType': requestType,
      'durationUnit': durationUnit,
      'durationAmount': durationAmount,
      'images': images.map((e) => (e as DigitalAdImageModel).toJson()).toList(),
      'approvedAt': approvedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'owner': owner is DigitalAdOwnerModel
          ? (owner as DigitalAdOwnerModel).toJson()
          : null,
      'enhancements': enhancements is DigitalAdEnhancementsModel
          ? (enhancements as DigitalAdEnhancementsModel).toJson()
          : null,
    };
  }
}
