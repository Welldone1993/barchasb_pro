import '../../domain/entities/ad_image_entity.dart';
import '../../domain/entities/enhancement_entity.dart';
import '../../domain/entities/owner_entity.dart';
import '../../domain/entities/seller_ad_detail_entity.dart';

class SellerAdDetailModel extends SellerAdDetailEntity {
  const SellerAdDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    super.state,
    super.city,
    required super.priceIRT,
    required super.isFixedPrice,
    required super.isNegotiable,
    required super.hasWarranty,
    required super.isShippable,
    required super.images,
    super.owner,
    required super.enhancements,
    required super.adStatus,
    required super.isPaid,
    super.createdAt,
  });

  factory SellerAdDetailModel.fromJson(Map<String, dynamic> json) {
    return SellerAdDetailModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      state: json['state']?.toString(),
      city: json['city']?.toString(),
      priceIRT: (json['priceIRT'] as num?)?.toInt() ?? 0,
      isFixedPrice: json['isFixedPrice'] == true,
      isNegotiable: json['isNegotiable'] == true,
      hasWarranty: json['hasWarranty'] == true,
      isShippable: json['isShippable'] == true,
      isPaid: json['isPaid'] == true,
      // default false in schema
      adStatus: json['adStatus']?.toString() ?? 'pending',
      images: json['images'] != null && json['images'] is List
          ? (json['images'] as List)
                .map((e) => AdImageModel.fromJson(e))
                .toList()
          : [],
      enhancements: json['enhancements'] != null
          ? EnhancementsModel.fromJson(json['enhancements'])
          : const EnhancementsModel(
              isSpecial: false,
              isLadder: false,
              ladders: [],
              specialEndDate: null,
              specialStartDate: null,
            ),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      owner: json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null,
    );
  }
}

class OwnerModel extends OwnerEntity {
  const OwnerModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) => OwnerModel(
    id: json['id'] ?? '',
    fullName: json['fullName'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
  );
}

class EnhancementsModel extends EnhancementsEntity {
  const EnhancementsModel({
    required super.isLadder,
    required super.ladders,
    required super.isSpecial,
    required super.specialEndDate,
    required super.specialStartDate,
  });

  factory EnhancementsModel.fromJson(Map<String, dynamic> json) {
    return EnhancementsModel(
      isSpecial: json['isSpecial'] ?? false,
      specialStartDate: json['specialStartDate'] != null
          ? DateTime.tryParse(json['specialStartDate'])
          : null,
      specialEndDate: json['specialEndDate'] != null
          ? DateTime.tryParse(json['specialEndDate'])
          : null,
      isLadder: json['isLadder'] ?? false,
      ladders: json['ladders'] != null && json['ladders'] is List
          ? json['ladders'] as List
          : [],
    );
  }
}

class AdImageModel extends AdImageEntity {
  const AdImageModel({required super.url, required super.isMain});

  factory AdImageModel.fromJson(Map<String, dynamic> json) {
    return AdImageModel(
      url: json['url']?.toString() ?? '',
      isMain: json['isMain'] == true,
    );
  }
}
