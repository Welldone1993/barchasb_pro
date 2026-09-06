import 'ad_image_entity.dart';
import 'enhancement_entity.dart';
import 'owner_entity.dart';

class SellerAdDetailEntity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String? state;
  final String? city;
  final int priceIRT; // عددی (Int)
  final bool isFixedPrice;
  final bool isNegotiable;
  final bool hasWarranty;
  final bool isShippable;
  final List<AdImageEntity> images;
  final OwnerEntity? owner;
  final EnhancementsEntity enhancements;
  final String adStatus;
  final bool isPaid;
  final DateTime? createdAt;

  const SellerAdDetailEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.state,
    this.city,
    required this.priceIRT,
    required this.isFixedPrice,
    required this.isNegotiable,
    required this.hasWarranty,
    required this.isShippable,
    required this.images,
    this.owner,
    required this.enhancements,
    required this.adStatus,
    required this.isPaid,
    this.createdAt,
  });
}

