import 'dart:io';
import 'package:barchasb/core/utils/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/employer_ad_provider.dart';
import '../providers/step_1_provider.dart';
import 'job_category_dialog.dart';

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
            // --- سوییچ برای خودم / دیگری ---
            Center(
              child: AdTargetToggle(
                isForSelf: formData.isForSelf,
                onChanged: (isForSelf) {
                  ref.read(step1Provider.notifier).updateData(isForSelf: isForSelf);
                },
              ),
            ),
            const SizedBox(height: 24),
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

  Future<void> _showCategoryDialog(BuildContext context, WidgetRef ref) async {
    final result = await JobCategoryDialog.show(
      context,
      initialSelected: ref.watch(step1Provider).categories,
    );

    if (result != null && result.isNotEmpty) {
      final categories = result;
      ref
          .read(step1Provider.notifier)
          .updateData(
            category: "${categories.length.toString().toPersianDigits} دسته ",
            categories: categories,
          );
    }
  }
}


// ==========================================
// ویجت سوییچ خودم / دیگری مطابق طرح Figma
// ==========================================
class AdTargetToggle extends StatefulWidget {
  final bool isForSelf;
  final ValueChanged<bool>? onChanged;

  const AdTargetToggle({
    super.key,
    this.isForSelf = true,
    this.onChanged,
  });

  @override
  State<AdTargetToggle> createState() => _AdTargetToggleState();
}

class _AdTargetToggleState extends State<AdTargetToggle> {
  late bool _isForSelf;

  @override
  void initState() {
    super.initState();
    _isForSelf = widget.isForSelf;
  }

  @override
  void didUpdateWidget(covariant AdTargetToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isForSelf != widget.isForSelf) {
      _isForSelf = widget.isForSelf;
    }
  }

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF0F3057);

    return FittedBox(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'می‌خواهم برای',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 38,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE4E7EC),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildOption(
                    title: 'خودم',
                    isSelected: _isForSelf,
                    activeColor: activeColor,
                    onTap: () {
                      if (!_isForSelf) {
                        setState(() => _isForSelf = true);
                        widget.onChanged?.call(true);
                      }
                    },
                  ),
                  _buildOption(
                    title: 'دیگری',
                    isSelected: !_isForSelf,
                    activeColor: activeColor,
                    onTap: () {
                      if (_isForSelf) {
                        setState(() => _isForSelf = false);
                        widget.onChanged?.call(false);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'آگهی بگذارم',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String title,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
