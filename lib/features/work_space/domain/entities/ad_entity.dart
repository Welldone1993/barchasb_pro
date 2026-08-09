import 'package:equatable/equatable.dart';

class AdEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? category;
  final String? subCategories;
  final String? imageUrl;
  final String? state;
  final String? city;
  final String? price;
  final bool isVerified;
  final bool isNegotiable;
  final bool hasWarranty;
  final bool isShippable;


  const AdEntity({
    required this.id,
    required this.title,
    this.description,
    this.category,
    this.subCategories,
    this.imageUrl,
    this.state,
    this.city,
    this.price,
    this.isVerified = false,
    this.isNegotiable = false,
    this.isShippable = false,
    this.hasWarranty = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    subCategories,
    imageUrl,
    price,
    isVerified,
  ];
}
