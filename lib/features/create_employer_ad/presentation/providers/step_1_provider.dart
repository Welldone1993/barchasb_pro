import 'package:flutter_riverpod/legacy.dart';

import '../../data/models/job_category_model.dart';

class Step1Data {
  final String? imagePath;
  final String name;
  final String title;
  final String category;
  final List<JobCategoryModel> categories;
  final String description;
  final bool isForSelf;

  Step1Data({
    this.imagePath,
    this.name = '',
    this.title = '',
    this.category = '',
    this.categories = const [],
    this.description = '',
    this.isForSelf = false,
  });

  Step1Data copyWith({
    String? imagePath,
    String? name,
    String? title,
    String? category,
    List<JobCategoryModel>? categories,
    String? description,
    bool? isForSelf,
  }) {
    return Step1Data(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      title: title ?? this.title,
      category: category ?? this.category,
      categories: categories ?? this.categories,
      description: description ?? this.description,
      isForSelf: isForSelf ?? this.isForSelf,
    );
  }
}

class Step1Notifier extends StateNotifier<Step1Data> {
  Step1Notifier() : super(Step1Data());

  void updateData({
    String? imagePath,
    String? name,
    String? title,
    String? category,
    List<JobCategoryModel>? categories,
    String? description,
    bool? isForSelf,

  }) {
    state = state.copyWith(
      imagePath: imagePath,
      name: name,
      title: title,
      category: category,
      categories: categories,
      description: description,
      isForSelf: isForSelf,
    );
  }
}

final step1Provider = StateNotifierProvider<Step1Notifier, Step1Data>((ref) {
  return Step1Notifier();
});
