import 'digital_ad_enhancements_entity.dart';
import 'digital_ad_image_entity.dart';
import 'digital_ad_owner_entity.dart';
import 'required_skill_entity.dart';

class DigitalAdEntity {
  final String? id;
  final String? ownerId;

  final String? title;
  final String? description;
  final String? digitalTotalDesc;

  final List<String> projectNames;
  final List<String> projectDescriptions;

  final String? minBudget;
  final String? maxBudget;

  final List<RequiredSkillEntity> requiredSkills;

  final String? person; // self | other
  final bool? remote;
  final bool? thursdayHalf;

  final String? paymentMethod; // Subscription | Wallet | Bank_card
  final String? adStatus;
  final String? requestType;
  final String? durationUnit;
  final int? durationAmount;

  final List<DigitalAdImageEntity> images;

  final DateTime? approvedAt;
  final DateTime? expiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final DigitalAdOwnerEntity? owner;
  final DigitalAdEnhancementsEntity? enhancements;

  const DigitalAdEntity({
    this.id,
    this.ownerId,
    this.title,
    this.description,
    this.digitalTotalDesc,
    this.projectNames = const [],
    this.projectDescriptions = const [],
    this.minBudget,
    this.maxBudget,
    this.requiredSkills = const [],
    this.person,
    this.remote,
    this.thursdayHalf,
    this.paymentMethod,
    this.adStatus,
    this.requestType,
    this.durationUnit,
    this.durationAmount,
    this.images = const [],
    this.approvedAt,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.enhancements,
  });
}
