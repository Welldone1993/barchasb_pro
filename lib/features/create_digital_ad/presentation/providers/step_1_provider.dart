import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

// کلاس داده استپ ۱ آگهی مناقصه
class Step1Data {
  final String title;
  final String minBudget;
  final String maxBudget;
  final String description;
  final List<XFile> photos; // تغییر از String به XFile

  Step1Data({
    this.title = '',
    this.minBudget = '',
    this.maxBudget = '',
    this.description = '',
    this.photos = const [],
  });

  Step1Data copyWith({
    String? title,
    String? minBudget,
    String? maxBudget,
    String? description,
    List<XFile>? photos,
  }) {
    return Step1Data(
      title: title ?? this.title,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      description: description ?? this.description,
      photos: photos ?? this.photos,
    );
  }
}

// مدیریت کننده وضعیت (Notifier)
class Step1Notifier extends StateNotifier<Step1Data> {
  Step1Notifier() : super(Step1Data());

  final ImagePicker _picker = ImagePicker();

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
    }
  }

  // متد جدید برای انتخاب تصاویر
  Future<void> pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      state = state.copyWith(photos: [...state.photos, ...pickedFiles]);
    }
  }

  // متد برای حذف تصویر انتخاب شده
  void removeImage(int index) {
    final newPhotos = List<XFile>.from(state.photos)..removeAt(index);
    state = state.copyWith(photos: newPhotos);
  }
}

// پروایدر استپ ۱
final step1Provider = StateNotifierProvider<Step1Notifier, Step1Data>((ref) {
  return Step1Notifier();
});
