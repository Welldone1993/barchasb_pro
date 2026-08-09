import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/seller_ad_provider.dart';
import '../providers/step_1_provider.dart';

class Step1BasicInfoScreen extends ConsumerWidget {
  const Step1BasicInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(step1Provider);
    final step1Notifier = ref.read(step1Provider.notifier);
    final notifier = ref.read(sellerAdProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      // رنگ پس‌زمینه خاکستری بسیار روشن
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // بخش انتخاب عکس
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'عکس های آگهی',
                            style: TextStyle(
                              color: Color(0xFF7A8B99),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              // قابلیت انتخاب چند عکس
                              final List<XFile> images = await picker
                                  .pickMultiImage();
                              if (images.isNotEmpty) {
                                for (var img in images) {
                                  step1Notifier.addImage(img.path);
                                }
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: state.imagePaths.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        File(state.imagePaths.last),
                                        // نمایش آخرین عکس انتخاب شده
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person, // آیکون پیش‌فرض طبق تصویر
                                      size: 40,
                                      color: Color(0xFF7A8B99),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // فیلد عنوان آگهی
                      _buildTextField(
                        hint: 'عنوان آگهی',
                        onChanged: step1Notifier.setTitle,
                      ),
                      const SizedBox(height: 20),

                      // فیلد دسته آگهی (با حالت دکمه برای باز کردن دیالوگ)
                      GestureDetector(
                        onTap: () {
                          // TODO: باز کردن BottomSheet یا Dialog برای انتخاب دسته‌بندی
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            state.category.isEmpty
                                ? 'دسته آگهی'
                                : state.category,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: state.category.isEmpty
                                  ? const Color(0xFFA5B2C4)
                                  : const Color(0xFF3B5978),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // فیلد توضیحات
                      _buildTextField(
                        hint: 'توضیحات',
                        onChanged: step1Notifier.setDescription,
                        maxLines: 5,
                        height: 140,
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
                    backgroundColor: const Color(0xFF3B5978), // آبی تیره
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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

  // ویجت کمکی برای فیلدهای متنی
  Widget _buildTextField({
    required String hint,
    required Function(String) onChanged,
    int maxLines = 1,
    double? height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        textAlign: TextAlign.right,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFA5B2C4), fontSize: 16),
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
