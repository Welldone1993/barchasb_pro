import '../../domain/entities/ad_entity.dart';

class AdModel extends AdEntity {
  const AdModel({
    required super.id,
    required super.title,
    super.description,
    super.category,
    super.subCategories,
    super.imageUrl,
    super.price,
    super.isVerified,
    super.city,
    super.state,
    super.hasWarranty,
    super.isNegotiable,
    super.isShippable,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    // استخراج اولین تصویر معتبر از لیست تصاویر
    String? extractedImageUrl;
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      final mainImage = (json['images'] as List).firstWhere(
        (img) => img['isMain'] == true,
        orElse: () => json['images'][0],
      );
      extractedImageUrl = mainImage['url'];
    }

    return AdModel(
      id: json['_id'] ?? '',
      // استفاده از _id به جای id
      title: json['title'] ?? json['name'] ?? '',
      // در برخی فایل‌ها name آمده است
      description:
          json['description'] ??
          (json['jobDetails'] != null && (json['jobDetails'] as List).isNotEmpty
              ? json['jobDetails'][0]['description']
              : null),
      category: json['category'] is String ? json['category'] : null,
      subCategories: json['subCategories'] is String
          ? json['subCategories']
          : null,
      imageUrl: extractedImageUrl,
      // در فایل‌های نمونه فیلد مستقیم price نبود، اگر در جای دیگری است اصلاح کنید
      price: json['priceIRT']?.toString(),
      isVerified: json['isVerified'] ?? false,
      city: json['city'],
      state: json['state'],
      hasWarranty: json['hasWarranty'],
      isNegotiable: json['isNegotiable'],
      isShippable: json['isShippable'],
    );
  }
}
