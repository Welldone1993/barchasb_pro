import 'package:flutter_riverpod/legacy.dart';

// پروایدر برای نگهداری لیست مهارت‌های مورد نیاز
class Step2Notifier extends StateNotifier<List<String>> {
  Step2Notifier() : super([]);

  // افزودن مهارت جدید
  void addSkill(String skill) {
    if (skill.trim().isNotEmpty && !state.contains(skill.trim())) {
      state = [...state, skill.trim()];
    }
  }

  // حذف یک مهارت
  void removeSkill(String skill) {
    state = state.where((s) => s != skill).toList();
  }
}

final step2Provider =
StateNotifierProvider<Step2Notifier, List<String>>((ref) {
  return Step2Notifier();
});
