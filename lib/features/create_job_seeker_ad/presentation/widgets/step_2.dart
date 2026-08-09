import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/job_seeker_ad_provider.dart';
import '../providers/step_2_provider.dart';

class Step2JobInfoScreen extends ConsumerWidget {
  const Step2JobInfoScreen({super.key});

  // ویجت کمکی برای انتخاب‌گرها (مثل حداقل حقوق، استان، شهر)
  Widget _buildSelector({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3B5978)),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF3B5978),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ویجت کمکی برای آپلود فایل
  Widget _buildFileUploader({
    required String title,
    String? filePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (filePath != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'انتخاب شد',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(color: Color(0xFFA5B2C4), fontSize: 14),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.upload_file, color: Color(0xFF3B5978)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(step2Provider);
    final step2Notifier = ref.read(step2Provider.notifier);
    final notifier = ref.read(jobSeekerAdProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // ردیف اول: حداقل و حداکثر حقوق (فرض بر این است که فیلد سمت راست هم حقوق است)
              Row(
                children: [
                  Expanded(
                    child: _buildSelector(
                      title: 'حداقل حقوق',
                      onTap: () {
                        // نمایش دیالوگ انتخاب حقوق
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSelector(
                      title: 'حداقل حقوق', // مطابق تصویر دو بار نوشته شده
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ردیف دوم: فایل رزومه و نمونه کار
              Row(
                children: [
                  Expanded(
                    child: _buildFileUploader(
                      title: 'فایل نمونه کار',
                      filePath: state.portfolioPath,
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();
                        if (result != null)
                          step2Notifier.setPortfolioPath(
                            result.files.single.path,
                          );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildFileUploader(
                      title: 'فایل رزومه',
                      filePath: state.resumePath,
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();
                        if (result != null)
                          step2Notifier.setResumePath(result.files.single.path);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // فیلد شماره تلفن
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.phone,
                  onChanged: step2Notifier.setPhoneNumber,
                  decoration: const InputDecoration(
                    hintText: 'شماره تلفن',
                    hintStyle: TextStyle(
                      color: Color(0xFFA5B2C4),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ردیف چهارم: استان و شهر
              Row(
                children: [
                  Expanded(
                    child: _buildSelector(
                      title: state.city.isEmpty ? 'شهر' : state.city,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSelector(
                      title: state.province.isEmpty ? 'استان' : state.province,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ردیف پنجم: سوابق شغلی و سایر مشخصات
              Row(
                children: [
                  Expanded(
                    child: _buildSelector(
                      title: 'سایر مشخصات',
                      onTap: () => _showOtherSpecsBottomSheet(context, ref),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSelector(
                      title: 'سوابق شغلی',
                      onTap: () => _showWorkExperienceBottomSheet(context, ref),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // دکمه‌های پایین
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2CB8FF), // آبی روشن
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => notifier.nextStep(),
                      child: const Text(
                        'مرحله قبل',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B5978),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        notifier.nextStep();
                      },
                      child: const Text(
                        'مرحله بعد',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Bottom Sheet سایر مشخصات ---
  void _showOtherSpecsBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF5F6F8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // هدر
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const CircleAvatar(
                      backgroundColor: Color(0xFFFF6B6B),
                      radius: 16,
                      child: Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                  const Text(
                    'سایر مشخصات',
                    style: TextStyle(
                      color: Color(0xFF3B5978),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // فیلدها (ساده شده)
              _buildSelector(title: 'وضعیت تاهل', onTap: () {}),
              const SizedBox(height: 16),
              _buildSelector(title: 'جنسیت', onTap: () {}),
              const SizedBox(height: 16),
              _buildSelector(title: 'وضعیت نظام وظیفه', onTap: () {}),
              const SizedBox(height: 16),
              _buildTextField(
                'اینستاگرام',
                (v) =>
                    ref.read(step2Provider.notifier).updateOtherSpecs(insta: v),
              ),
              _buildTextField(
                'لینکدین',
                (v) => ref
                    .read(step2Provider.notifier)
                    .updateOtherSpecs(linked: v),
              ),
              _buildTextField(
                'گیت هاب',
                (v) =>
                    ref.read(step2Provider.notifier).updateOtherSpecs(git: v),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  // --- Bottom Sheet سوابق شغلی ---
  void _showWorkExperienceBottomSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF5F6F8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(step2Provider);
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const CircleAvatar(
                            backgroundColor: Color(0xFFFF6B6B),
                            radius: 16,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const Text(
                          'سوابق شغلی',
                          style: TextStyle(
                            color: Color(0xFF3B5978),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'شرح سوابق',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'موقعیت شغلی',
                      (v) {},
                      controller: titleController,
                    ),
                    _buildTextField(
                      'توضیحات',
                      (v) {},
                      controller: descController,
                      maxLines: 3,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B5978),
                        ),
                        onPressed: () {
                          if (titleController.text.isNotEmpty) {
                            ref
                                .read(step2Provider.notifier)
                                .addWorkExperience(
                                  WorkExperience(
                                    title: titleController.text,
                                    description: descController.text,
                                  ),
                                );
                            titleController.clear();
                            descController.clear();
                          }
                        },
                        child: const Text(
                          'افزودن',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // لیست سوابق اضافه شده
                    ...state.workExperiences.asMap().entries.map((entry) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            entry.value.title,
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            entry.value.description,
                            textAlign: TextAlign.right,
                          ),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () => ref
                                    .read(step2Provider.notifier)
                                    .removeWorkExperience(entry.key),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                    const Text(
                      'درباره من',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'توضیحات (اختیاری)',
                      (v) => ref.read(step2Provider.notifier).setAboutMe(v),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(
    String hint,
    Function(String) onChanged, {
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        maxLines: maxLines,
        onChanged: onChanged,
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
