import '../../domain/entities/digital_ad_image_entity.dart';

class DigitalAdImageModel extends DigitalAdImageEntity {
  const DigitalAdImageModel({required super.url, required super.isMain});

  factory DigitalAdImageModel.fromJson(Map<String, dynamic> json) {
    return DigitalAdImageModel(
      url: json['url'] ?? '',
      isMain: json['isMain'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'isMain': isMain};
  }
}
