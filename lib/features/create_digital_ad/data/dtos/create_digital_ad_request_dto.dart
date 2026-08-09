import 'required_skill_dto.dart';

class CreateDigitalAdRequestDto {
  final String? owner;
  final String? title;
  final String? description;
  final String? digitalTotalDesc;
  final List<String>? projectNames;
  final List<String>? projectDescriptions;
  final String? minBudget;
  final String? maxBudget;
  final List<RequiredSkillDto>? requiredSkills;
  final String? person; // self | other
  final bool? remote;
  final bool? thursdayHalf;
  final String? paymentMethod; // Subscription | Wallet | Bank_card
  final String? verifyCode;
  final String? adStatus;
  final String? requestType;
  final String? durationUnit;
  final int? durationAmount;
  final DateTime? approvedAt;
  final DateTime? expiresAt;

  /// برای multipart/form-data:
  /// در Flutter معمولاً Fileها مستقیم داخل DTO نگهداری نمی‌شوند،
  /// ولی اگر بخواهی می‌توانی اینجا لیست مسیر/فایل یا Uint8List بگذاری.
  final List<dynamic>? images;

  const CreateDigitalAdRequestDto({
    this.owner,
    this.title,
    this.description,
    this.digitalTotalDesc,
    this.projectNames,
    this.projectDescriptions,
    this.minBudget,
    this.maxBudget,
    this.requiredSkills,
    this.person,
    this.remote,
    this.thursdayHalf,
    this.paymentMethod,
    this.verifyCode,
    this.adStatus,
    this.requestType,
    this.durationUnit,
    this.durationAmount,
    this.approvedAt,
    this.expiresAt,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'title': title,
      'description': description,
      'digitalTotalDesc': digitalTotalDesc,
      'projectNames': projectNames,
      'projectDescriptions': projectDescriptions,
      'minBudget': minBudget,
      'maxBudget': maxBudget,
      'requiredSkills': requiredSkills?.map((e) => e.toJson()).toList(),
      'person': person,
      'remote': remote,
      'thursdayHalf': thursdayHalf,
      'paymentMethod': paymentMethod,
      'verifyCode': verifyCode,
      'adStatus': adStatus,
      'requestType': requestType,
      'durationUnit': durationUnit,
      'durationAmount': durationAmount,
      'approvedAt': approvedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}
