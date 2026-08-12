import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/digital_ad_provider.dart';
import '../providers/step_1_provider.dart';

class Step1BasicInfoScreen extends ConsumerWidget {
  const Step1BasicInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step1Data = ref.watch(step1Provider); // گوش دادن به تغییرات دیتا
    final step1Notifier = ref.read(step1Provider.notifier);
    final mainNotifier = ref.read(digitalAdProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // رنگ پس‌زمینه یکپارچه
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl, // راست‌چین کردن کل صفحه
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        // بخش انتخاب عکس آگهی
                        GestureDetector(
                            onTap: () => step1Notifier.pickImages(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'عکس های آگهی',
                                style: TextStyle(
                                  color: Color(0xFF7B8794),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (step1Data.photos.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Wrap(
                                    spacing: 8,
                                    children: List.generate(step1Data.photos.length, (index) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.file(
                                              File(step1Data.photos[index].path),
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () => step1Notifier.removeImage(index),
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Colors.red,
                                                child: Icon(Icons.close, size: 12, color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              if (step1Data.photos.isEmpty)
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE2E8F0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.person, // آیکون پیش‌فرض طبق تصویر
                                  color: Color(0xFF7B8794),
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // فرم‌ها
                        _buildTextField(
                          'عنوان آگهی',
                          (val) => step1Notifier.updateField('title', val),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'حداقل بودجه',
                          (val) =>
                              step1Notifier.updateField('minBudget', val),
                          isNumber: true, // کیبورد عددی
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'حداکثر بودجه',
                          (val) =>
                              step1Notifier.updateField('maxBudget', val),
                          isNumber: true, // کیبورد عددی
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'توضیحات',
                          (val) =>
                              step1Notifier.updateField('description', val),
                        ),
                      ],
                    ),
                  ),
                ),

                // دکمه مرحله بعد
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B5978),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      mainNotifier.nextStep();
                    },
                    child: const Text(
                      'مرحله بعد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ویجت سازنده فیلدهای ورودی (کپسوله شده برای جلوگیری از تکرار کد)
  Widget _buildTextField(
    String hint,
    Function(String) onChanged, {
    bool isNumber = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        textAlign: TextAlign.right,
        onChanged: onChanged,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Color(0xFF3B5978), fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFA5B2C4), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
