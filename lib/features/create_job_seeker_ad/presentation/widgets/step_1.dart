import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/job_seeker_ad_provider.dart';
import '../providers/step_1_provider.dart';

class Step1BasicInfoScreen extends ConsumerWidget {
  const Step1BasicInfoScreen({super.key});

  // متد کمکی برای ساخت فیلدهای متنی مشابه تصویر
  Widget _buildCustomTextField({
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFA5B2C4), // رنگ خاکستری روشن برای متن راهنما
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none, // حذف خط زیرین
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(step1Provider);
    final step1Notifier = ref.read(step1Provider.notifier);
    final notifier = ref.read(jobSeekerAdProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // رنگ پس‌زمینه فرم
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // بخش انتخاب عکس پروفایل
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'عکس پروفایل',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7B8B9E),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        step1Notifier.setImage(pickedFile.path);
                      }
                    },
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFFDCE3ED),
                      backgroundImage: state.imagePath != null
                          ? FileImage(File(state.imagePath!))
                          : null,
                      child: state.imagePath == null
                          ? const Icon(
                              Icons.person,
                              color: Color(0xFF7B8B9E),
                              size: 40,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // فیلد نام
              _buildCustomTextField(
                hint: 'نام',
                onChanged: step1Notifier.setName,
              ),

              // فیلد سن
              _buildCustomTextField(
                hint: 'سن',
                keyboardType: TextInputType.number,
                onChanged: step1Notifier.setAge,
              ),

              // فیلد تحصیلات
              _buildCustomTextField(
                hint: 'تحصیلات',
                onChanged: step1Notifier.setEducation,
              ),

              // فیلد حقوق پیشنهادی
              _buildCustomTextField(
                hint: 'حقوق پیشنهادی (به تومان) ...',
                keyboardType: TextInputType.number,
                onChanged: step1Notifier.setSalary,
              ),

              const SizedBox(height: 40),

              // دکمه مرحله بعد
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B5978), // رنگ سرمه‌ای
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    notifier.nextStep();
                  },
                  child: const Text(
                    'مرحله بعد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
