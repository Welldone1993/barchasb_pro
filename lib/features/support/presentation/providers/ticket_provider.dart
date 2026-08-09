// فایل: lib/providers/ticket_provider.dart

import 'package:flutter_riverpod/legacy.dart';

// مدل وضعیت فرم تیکت
class TicketState {
  final String email;
  final String title;
  final String description;
  final bool isLoading;

  TicketState({
    this.email = '',
    this.title = '',
    this.description = '',
    this.isLoading = false,
  });

  TicketState copyWith({
    String? email,
    String? title,
    String? description,
    bool? isLoading,
  }) {
    return TicketState(
      email: email ?? this.email,
      title: title ?? this.title,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// مدیریت کننده وضعیت
class TicketNotifier extends StateNotifier<TicketState> {
  TicketNotifier() : super(TicketState());

  void updateEmail(String email) => state = state.copyWith(email: email);

  void updateTitle(String title) => state = state.copyWith(title: title);

  void updateDescription(String desc) =>
      state = state.copyWith(description: desc);

  void clearFields() {
    state = state.copyWith(email: '', title: '', description: '');
  }

  // متد ارسال تیکت (آماده برای اتصال به API)
  Future<bool> submitTicket() async {
    // 1. نمایش حالت لودینگ
    state = state.copyWith(isLoading: true);

    try {
      // TODO: در اینجا کد فراخوانی API را قرار دهید
      // مثلا: await api.sendTicket(state.email, state.title, state.description);

      // شبیه‌سازی زمان اتصال به سرور (۱ ثانیه)
      await Future.delayed(const Duration(seconds: 1));

      // 2. موفقیت‌آمیز بودن درخواست
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      // مدیریت خطا
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}

// تعریف پروایدر
final ticketProvider = StateNotifierProvider<TicketNotifier, TicketState>((
  ref,
) {
  return TicketNotifier();
});
