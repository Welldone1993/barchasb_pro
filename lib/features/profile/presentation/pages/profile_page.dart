import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider(userId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'پروفایل کاربری',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
      ),
      body: profileState.when(
        loading: () => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text(
                'در حال دریافت اطلاعات...',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => ref.refresh(profileProvider(userId)),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('تلاش مجدد'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A5F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        data: (profileData) => _ProfileContent(data: profileData),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final UserProfileDataEntity data;

  const _ProfileContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final user = data.user;
    final profile = data.profile;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // عکس پروفایل با آیکون ادیت
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 46,
                      backgroundColor: const Color(0xFFE2E8F0),
                      backgroundImage:
                          (profile.profileImage != null &&
                              profile.profileImage!.isNotEmpty)
                          ? NetworkImage(profile.profileImage!)
                          : null,
                      child:
                          (profile.profileImage == null ||
                              profile.profileImage!.isEmpty)
                          ? const Icon(
                              Icons.person,
                              size: 48,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: Color(0xFF1E3A5F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // نام کاربری
              _buildLabeledField(
                label: 'نام کاربری',
                value: user.username ?? 'ثبت نشده',
              ),
              const SizedBox(height: 12),

              // شماره تلفن با دکمه تایید
              _buildVerifiedField(
                label: 'شماره تلفن',
                value: user.phone,
                isConfirmed: user.phoneConfirmed,
              ),
              const SizedBox(height: 12),

              // ایمیل با دکمه تایید
              _buildVerifiedField(
                label: 'ایمیل',
                value: user.email ?? 'ثبت نشده',
                isConfirmed: user.emailConfirmed,
              ),
              const SizedBox(height: 12),

              // کد ملی
              _buildLabeledField(
                label: 'کد ملی',
                value: user.nationalCode ?? 'ثبت نشده',
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Color(0xFFE2E8F0)),
              ),

              // نام و نام خانوادگی
              Row(
                children: [
                  Expanded(
                    child: _buildLabeledField(label: 'نام', value: user.name),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLabeledField(
                      label: 'نام خانوادگی',
                      value: user.lastName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // استان و شهر
              Row(
                children: [
                  Expanded(
                    child: _buildLabeledField(
                      label: 'استان',
                      value: user.province ?? 'ثبت نشده',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLabeledField(
                      label: 'شهر',
                      value: user.city ?? 'ثبت نشده',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // آدرس
              _buildLabeledField(
                label: 'آدرس',
                value: profile.address ?? 'ثبت نشده',
              ),
              const SizedBox(height: 12),

              // مدرک تحصیلی و تاریخ تولد
              Row(
                children: [
                  Expanded(
                    child: _buildLabeledField(
                      label: 'آخرین مدرک تحصیلی',
                      value: profile.educationLevel ?? 'ثبت نشده',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLabeledField(
                      label: 'تاریخ تولد',
                      value: user.birthDate ?? 'ثبت نشده',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // درباره من
              _buildLabeledField(
                label: 'درباره من',
                value: profile.aboutMe ?? 'توضیحاتی ثبت نشده است...',
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // علاقه‌مندی‌ها
              _buildChipSection(
                title: 'علاقه‌مندی‌ها',
                items: profile.interests,
                placeholder: 'علاقه‌مندی‌ها...',
              ),
              const SizedBox(height: 16),

              // مهارت‌ها
              _buildChipSection(
                title: 'مهارت‌ها',
                items: profile.skills,
                placeholder: 'مهارت‌ها...',
              ),
              const SizedBox(height: 20),

              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 12),

              // بارگذاری رزومه و نمونه‌کارها (Placeholder برای استپ‌های بعدی)
              Row(
                children: [
                  Expanded(
                    child: _buildUploadPlaceholder(
                      title: 'بارگذاری فایل رزومه',
                      fileName: profile.resumeFile,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildUploadPlaceholder(
                      title: 'بارگذاری نمونه کارها',
                      fileName: profile.portfolioFiles.isNotEmpty
                          ? '${profile.portfolioFiles.length} فایل'
                          : null,
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

  Widget _buildLabeledField({
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0).withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Color(0xFF334155)),
          ),
        ),
      ],
    );
  }

  Widget _buildVerifiedField({
    required String label,
    required String value,
    required bool isConfirmed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isConfirmed
                    ? const Color(0xFF1E3A5F)
                    : const Color(0xFF94A3B8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isConfirmed ? 'تأیید شده' : 'تأیید نشده',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChipSection({
    required String title,
    required List<String> items,
    required String placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        if (items.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0).withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              placeholder,
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF334155),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildUploadPlaceholder({required String title, String? fileName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0).withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.attach_file, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  fileName ?? 'فایلی وجود ندارد',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
