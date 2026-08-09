import '../../domain/entities/seller_ad_entity.dart';

class SellerAdModel extends SellerAdEntity {
  const SellerAdModel({
    required super.id,
    required super.name,
    super.category,
    super.state,
    super.city,
    super.skills = const [],
    super.ratingAverage = 0.0,
    super.imageUrl,
  });

  factory SellerAdModel.fromJson(Map<String, dynamic> json) {
    // ۱. استخراج عکس اصلی (اگر وجود داشت)
    String? extractedImageUrl;
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      final mainImage = (json['images'] as List).firstWhere(
        (img) => img['isMain'] == true,
        orElse: () => json['images'][0],
      );
      extractedImageUrl = mainImage['url'];
    }

    // ۲. استخراج مهارت‌ها به صورت لیستی از String
    List<String> parsedSkills = [];
    if (json['skills'] != null && json['skills'] is List) {
      parsedSkills = (json['skills'] as List).map((e) => e.toString()).toList();
    }

    // ۳. استخراج میانگین امتیاز
    double parsedRating = 0.0;
    if (json['rating'] != null && json['rating']['average'] != null) {
      parsedRating = (json['rating']['average'] as num).toDouble();
    }

    // ۴. ساخت مدل
    return SellerAdModel(
      id: json['_id'] ?? '',
      // در دیتای شما گاهی name بود و گاهی title، هر دو را چک می‌کنیم
      name: json['name'] ?? json['title'] ?? 'بدون نام',
      category: json['category'] is String ? json['category'] : null,
      state: json['state'] is String ? json['state'] : null,
      city: json['city'] is String ? json['city'] : null,
      skills: parsedSkills,
      ratingAverage: parsedRating,
      imageUrl: extractedImageUrl,
    );
  }
}
