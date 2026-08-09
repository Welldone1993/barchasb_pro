import 'package:flutter_riverpod/legacy.dart';

class Step1Data {
  final String? imagePath;
  final String name;
  final String title;
  final String category;
  final String description;

  Step1Data({
    this.imagePath,
    this.name = '',
    this.title = '',
    this.category = '',
    this.description = '',
  });

  Step1Data copyWith({
    String? imagePath,
    String? name,
    String? title,
    String? category,
    String? description,
  }) {
    return Step1Data(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
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
    String? description,
  }) {
    state = state.copyWith(
      imagePath: imagePath,
      name: name,
      title: title,
      category: category,
      description: description,
    );
  }
}

final step1Provider =
StateNotifierProvider<Step1Notifier, Step1Data>((ref) {
  return Step1Notifier();
});
