import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/employer_ad_provider.dart';
import '../providers/step_1_provider.dart';

class Step1BasicInfoScreen extends ConsumerWidget {
  const Step1BasicInfoScreen({super.key});

  Future<void> _pickImage(WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ref.read(step1Provider.notifier).updateData(imagePath: pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(step1Provider);
    final notifier = ref.read(employerAdProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // رنگ پس زمینه روشن
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // --- انتخاب عکس پروفایل ---
            GestureDetector(
              onTap: () => _pickImage(ref),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'عکس پروفایل',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueGrey.withOpacity(0.2),
                    backgroundImage: formData.imagePath != null
                        ? FileImage(File(formData.imagePath!))
                        : null,
                    child: formData.imagePath == null
                        ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blueGrey,
                          )
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- فیلد نام ---
            _buildTextField(
              hint: 'نام',
              onChanged: (val) =>
                  ref.read(step1Provider.notifier).updateData(name: val),
            ),
            const SizedBox(height: 16),

            // --- فیلد عنوان آگهی ---
            _buildTextField(
              hint: 'عنوان آگهی',
              onChanged: (val) =>
                  ref.read(step1Provider.notifier).updateData(title: val),
            ),
            const SizedBox(height: 16),

            // --- دکمه انتخاب دسته شغلی ---
            GestureDetector(
              onTap: () => _showCategoryDialog(context, ref),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      formData.category.isEmpty
                          ? 'دسته شغلی'
                          : formData.category,
                      style: TextStyle(
                        color: formData.category.isEmpty
                            ? Colors.grey
                            : Colors.blueGrey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- فیلد توضیحات ---
            _buildTextField(
              hint: 'توضیحات',
              maxLines: 4,
              onChanged: (val) =>
                  ref.read(step1Provider.notifier).updateData(description: val),
            ),
            const SizedBox(height: 32),

            // --- دکمه مرحله بعد ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B5978), // رنگ دکمه آبی تیره
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  notifier.nextStep();
                  print(
                    'Name: ${formData.name}, Category: ${formData.category}',
                  );
                },
                child: const Text(
                  'مرحله بعد',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // متد کمکی برای ساخت فیلدهای متنی
  Widget _buildTextField({
    required String hint,
    required Function(String) onChanged,
    int maxLines = 1,
  }) {
    return TextField(
      onChanged: onChanged,
      maxLines: maxLines,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // --- دیالوگ دسته بندی ها ---
  void _showCategoryDialog(BuildContext context, WidgetRef ref) {
    // یک لیست نمونه برای دسته بندی ها
    final categories = [
      'بازی سازی',
      'برنامه نویسی',
      'طراحی گرافیک',
      'دیجیتال مارکتینگ',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: const Color(0xFFF5F6F8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // هدر دیالوگ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'انتخاب دسته ها',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // باکس جستجو
                TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: '... جستجوی دسته',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // لیست دسته‌ها
                SizedBox(
                  height: 300, // محدود کردن ارتفاع لیست
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // با کلیک روی دسته، مقدار در پروایدر آپدیت شده و دیالوگ بسته میشود
                          ref
                              .read(step1Provider.notifier)
                              .updateData(category: categories[index]);
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // چک باکس دکوری (غیر فعال، فقط برای نمایش)
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Text(
                                categories[index],
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
