import 'package:flutter_riverpod/legacy.dart';

// کلاس داده استپ ۲
class Step2Data {
  final String province;
  final String city;
  final String condition;
  final String usage;
  final String price;
  final bool isFixedPrice;
  final bool isExchangeable;
  final bool hasWarranty;
  final bool canShip;

  // فیلدهای دیالوگ سایر ویژگی‌ها
  final String toolType;
  final String brand;
  final String model;
  final String power;
  final String technicalSpecs;
  final String includedItems;
  final String warrantyMonths;

  Step2Data({
    this.province = '',
    this.city = '',
    this.condition = '',
    this.usage = '',
    this.price = '',
    this.isFixedPrice = false,
    this.isExchangeable = false,
    this.hasWarranty = false,
    this.canShip = false,
    this.toolType = '',
    this.brand = '',
    this.model = '',
    this.power = '',
    this.technicalSpecs = '',
    this.includedItems = '',
    this.warrantyMonths = '',
  });

  Step2Data copyWith({
    String? province, String? city, String? condition, String? usage,
    String? price, bool? isFixedPrice, bool? isExchangeable,
    bool? hasWarranty, bool? canShip, String? toolType, String? brand,
    String? model, String? power, String? technicalSpecs,
    String? includedItems, String? warrantyMonths,
  }) {
    return Step2Data(
      province: province ?? this.province,
      city: city ?? this.city,
      condition: condition ?? this.condition,
      usage: usage ?? this.usage,
      price: price ?? this.price,
      isFixedPrice: isFixedPrice ?? this.isFixedPrice,
      isExchangeable: isExchangeable ?? this.isExchangeable,
      hasWarranty: hasWarranty ?? this.hasWarranty,
      canShip: canShip ?? this.canShip,
      toolType: toolType ?? this.toolType,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      power: power ?? this.power,
      technicalSpecs: technicalSpecs ?? this.technicalSpecs,
      includedItems: includedItems ?? this.includedItems,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
    );
  }
}

class Step2Notifier extends StateNotifier<Step2Data> {
  Step2Notifier() : super(Step2Data());

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'province': state = state.copyWith(province: value); break;
      case 'city': state = state.copyWith(city: value); break;
      case 'condition': state = state.copyWith(condition: value); break;
      case 'usage': state = state.copyWith(usage: value); break;
      case 'price': state = state.copyWith(price: value); break;
      case 'isFixedPrice': state = state.copyWith(isFixedPrice: value); break;
      case 'isExchangeable': state = state.copyWith(isExchangeable: value); break;
      case 'hasWarranty': state = state.copyWith(hasWarranty: value); break;
      case 'canShip': state = state.copyWith(canShip: value); break;
      case 'toolType': state = state.copyWith(toolType: value); break;
      case 'brand': state = state.copyWith(brand: value); break;
      case 'model': state = state.copyWith(model: value); break;
      case 'power': state = state.copyWith(power: value); break;
      case 'technicalSpecs': state = state.copyWith(technicalSpecs: value); break;
      case 'includedItems': state = state.copyWith(includedItems: value); break;
      case 'warrantyMonths': state = state.copyWith(warrantyMonths: value); break;
    }
  }
}

final step2Provider = StateNotifierProvider<Step2Notifier, Step2Data>((ref) {
  return Step2Notifier();
});
