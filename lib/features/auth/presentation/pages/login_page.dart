import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../providers/login_provider.dart';


class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    const Color darkBlue = Color(0xFF153354);
    const Color lightGrey = Color(0xFFF3F4F6);
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBackButton(onPressed: () => context.go('/'),),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'ورود',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        controller: phoneController,
                        hint: 'شماره تلفن',
                        icon: Icons.phone_enabled_rounded,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: passwordController,
                        hint: 'رمز ورود',
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: AppElevatedButton(
                          isLoading: state.isLoading,
                          onPressed: () {
                            // context.pushReplacement('/dashboard');
                            // return;
                            if (phoneController.text.trim().isEmpty ||
                                passwordController.text.trim().isEmpty) {
                              return;
                            }
                            ref
                                .read(loginProvider.notifier)
                                .login(
                                  context,
                                  phoneController.text.trim(),
                                  passwordController.text.trim(),
                                );
                          },
                          text: 'ورود',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => context.push('/register'),
                            child: const Text(
                              'ثبت نام',
                              style: TextStyle(color: darkBlue),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'فراموشی رمز عبور',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: darkBlue,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                      bottom: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Image.asset('assets/logo_dark.png', width: 120),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Icon(icon, color: const Color(0xFF153354)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF153354)),
        ),
      ),
    );
  }
}
