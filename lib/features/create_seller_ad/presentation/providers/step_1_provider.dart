import 'package:flutter_riverpod/legacy.dart';

// کلاس داده استپ ۱ آگهی‌گذار
class Step1Data {
  final List<String> imagePaths; // می‌تواند شامل چندین عکس باشد
  final String title;
  final String category;
  final String description;

  Step1Data({
    this.imagePaths = const [],
    this.title = '',
    this.category = '',
    this.description = '',
  });

  Step1Data copyWith({
    List<String>? imagePaths,
    String? title,
    String? category,
    String? description,
  }) {
    return Step1Data(
      imagePaths: imagePaths ?? this.imagePaths,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}

// StateNotifier
class Step1Notifier extends StateNotifier<Step1Data> {
  Step1Notifier() : super(Step1Data());

  void addImage(String path) {
    state = state.copyWith(imagePaths: [...state.imagePaths, path]);
  }

  void setTitle(String value) => state = state.copyWith(title: value);

  void setCategory(String value) => state = state.copyWith(category: value);

  void setDescription(String value) =>
      state = state.copyWith(description: value);
}

final step1Provider =
    StateNotifierProvider<Step1Notifier, Step1Data>((ref) {
      return Step1Notifier();
    });
