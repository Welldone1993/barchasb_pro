class CreateSellerAdEntity {
  final String? title;
  final String? category;
  final String? state;
  final String? city;
  final num? priceIRT;
  final bool? isFixedPrice;
  final bool? isNegotiable;
  final bool? hasWarranty;
  final bool? isShippable;
  final Map<String, dynamic>? extraFeatures;
  final int? mainImageIndex;
  final String? person;
  final String? paymentMethod;
  final List<String>? images;

  CreateSellerAdEntity({
    this.title,
    this.category,
    this.state,
    this.city,
    this.priceIRT,
    this.isFixedPrice,
    this.isNegotiable,
    this.hasWarranty,
    this.isShippable,
    this.extraFeatures,
    this.mainImageIndex,
    this.person,
    this.paymentMethod,
    this.images,
  });
}
