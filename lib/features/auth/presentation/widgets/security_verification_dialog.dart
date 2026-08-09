// lib/features/auth/presentation/widgets/security_verification_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/otp_provider.dart';

class SecurityVerificationDialog extends ConsumerStatefulWidget {
  final String phoneNumber;

  const SecurityVerificationDialog({super.key, required this.phoneNumber});

  @override
  ConsumerState<SecurityVerificationDialog> createState() =>
      _SecurityVerificationDialogState();
}

class _SecurityVerificationDialogState
    extends ConsumerState<SecurityVerificationDialog> {
  final TextEditingController _captchaCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();

  @override
  void dispose() {
    _captchaCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(otpProvider);

    ref.listen<OtpState>(otpProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24), // برای بالانس کردن دکمه بستن
                  const Text(
                    'تایید امنیتی',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'کد تایید به شماره زیر ارسال می‌شود',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.phoneNumber,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.yellow,
                      Colors.lightBlueAccent,
                      Colors.greenAccent,
                      Colors.pinkAccent,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    '6 7 5 9 4',
                    style: TextStyle(
                      letterSpacing: 10,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(controller: _captchaCtrl, hintText: 'کد کپچا'),
              const SizedBox(height: 16),
              AppElevatedButton(
                text: 'تایید کپچا',
                isLoading: state.isLoading && !state.isCaptchaVerified,
                onPressed: () {
                  if (_captchaCtrl.text.isNotEmpty) {
                    ref
                        .read(otpProvider.notifier)
                        .sendOtp(widget.phoneNumber, _captchaCtrl.text);
                  }
                },
              ),
              if (state.isCaptchaVerified) ...[
                const SizedBox(height: 16),
                AppTextField(controller: _otpCtrl, hintText: 'کد پیامک'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppElevatedButton(
                        text: 'بررسی کد',
                        isLoading: state.isLoading,
                        onPressed: () {
                          if (_otpCtrl.text.isNotEmpty) {
                            ref
                                .read(otpProvider.notifier)
                                .verifyOtp(widget.phoneNumber, _otpCtrl.text);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppElevatedButton(
                        text: 'ارسال کد',
                        onPressed: () {
                          // ارسال مجدد کد
                          ref
                              .read(otpProvider.notifier)
                              .sendOtp(widget.phoneNumber, _captchaCtrl.text);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'کپچا تایید شد، حالا کد پیامک را ارسال کنید',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
