import 'package:flutter_riverpod/legacy.dart';

// کلاس داده استپ ۱ آگهی دیجیتال
class Step1Data {
  final List<String> photos; // می‌تواند از نوع XFile هم باشد
  final String title;
  final String minBudget;
  final String maxBudget;
  final String description;

  Step1Data({
    this.photos = const [],
    this.title = '',
    this.minBudget = '',
    this.maxBudget = '',
    this.description = '',
  });

  Step1Data copyWith({
    List<String>? photos,
    String? title,
    String? minBudget,
    String? maxBudget,
    String? description,
  }) {
    return Step1Data(
      photos: photos ?? this.photos,
      title: title ?? this.title,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      description: description ?? this.description,
    );
  }
}

// مدیریت کننده وضعیت (Notifier)
class Step1Notifier extends StateNotifier<Step1Data> {
  Step1Notifier() : super(Step1Data());

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'title':
        state = state.copyWith(title: value);
        break;
      case 'minBudget':
        state = state.copyWith(minBudget: value);
        break;
      case 'maxBudget':
        state = state.copyWith(maxBudget: value);
        break;
      case 'description':
        state = state.copyWith(description: value);
        break;
      case 'photos':
        state = state.copyWith(photos: value);
        break;
    }
  }
}

// پروایدر استپ ۱
final step1Provider = StateNotifierProvider<Step1Notifier, Step1Data>((
  ref,
) {
  return Step1Notifier();
});
