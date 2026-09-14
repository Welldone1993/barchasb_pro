import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/update_profile_dto.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for User fields
  late TextEditingController _nameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _usernameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _birthDateCtrl;
  late TextEditingController _provinceCtrl;
  late TextEditingController _cityCtrl;

  // Controllers for Profile fields
  late TextEditingController _addressCtrl;
  late TextEditingController _educationCtrl;
  late TextEditingController _aboutMeCtrl;
  late TextEditingController _skillsCtrl;
  late TextEditingController _interestsCtrl;

  final ImagePicker _picker = ImagePicker();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _usernameCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _birthDateCtrl = TextEditingController();
    _provinceCtrl = TextEditingController();
    _cityCtrl = TextEditingController();

    _addressCtrl = TextEditingController();
    _educationCtrl = TextEditingController();
    _aboutMeCtrl = TextEditingController();
    _skillsCtrl = TextEditingController();
    _interestsCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileNotifierProvider.notifier).fetchProfile(widget.userId);
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _lastNameCtrl.dispose();
    _usernameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _birthDateCtrl.dispose();
    _provinceCtrl.dispose();
    _cityCtrl.dispose();
    _addressCtrl.dispose();
    _educationCtrl.dispose();
    _aboutMeCtrl.dispose();
    _skillsCtrl.dispose();
    _interestsCtrl.dispose();
    super.dispose();
  }

  void _populateFields(dynamic profileData) {
    if (_isInitialized || profileData == null) return;

    final user = profileData.user;
    final profile = profileData.profile;

    if (user != null) {
      _nameCtrl.text = user.name ?? '';
      _lastNameCtrl.text = user.lastName ?? '';
      _usernameCtrl.text = user.username ?? '';
      _phoneCtrl.text = user.phone ?? '';
      _emailCtrl.text = user.email ?? '';
      _birthDateCtrl.text = user.birthDate ?? '';
      _provinceCtrl.text = user.province ?? '';
      _cityCtrl.text = user.city ?? '';
    }

    if (profile != null) {
      _addressCtrl.text = profile.address ?? '';
      _educationCtrl.text = profile.educationLevel ?? '';
      _aboutMeCtrl.text = profile.aboutMe ?? '';
      _skillsCtrl.text = profile.skills?.join(', ') ?? '';
      _interestsCtrl.text = profile.interests?.join(', ') ?? '';
    }

    _isInitialized = true;
  }

  Future<void> _pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      final file = File(image.path);
      await ref.read(profileNotifierProvider.notifier).uploadProfilePhoto(file);
    }
  }

  Future<void> _saveProfile() async{
    if (!_formKey.currentState!.validate()) return;

    final skillsList = _skillsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final interestsList = _interestsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final dto = UpdateProfileDto(
      user: UpdateUserDataDto(
        name: _nameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        username: _usernameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        birthDate: _birthDateCtrl.text.trim(),
        province: _provinceCtrl.text.trim(),
        city: _cityCtrl.text.trim(),
      ),
      profile: UpdateProfileDataDto(
        address: _addressCtrl.text.trim(),
        educationLevel: _educationCtrl.text.trim(),
        aboutMe: _aboutMeCtrl.text.trim(),
        skills: skillsList,
        interests: interestsList,
      ),
    );

   final result = await ref.read(profileNotifierProvider.notifier).updateProfile(dto);
   if(result && context.mounted){
       context.pushReplacement('/dashboard');
   }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileNotifierProvider);

    ref.listen<ProfileState>(profileNotifierProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.errorMessage!,
              style: const TextStyle(fontFamily: 'IRANYekan'),
            ),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.successMessage!,
              style: const TextStyle(fontFamily: 'IRANYekan'),
            ),
            backgroundColor: Colors.green.shade700,
          ),
        );
      }
      if (next.profileData != null && !_isInitialized) {
        _populateFields(next.profileData);
      }
    });

    if (state.isLoading && state.profileData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final profileImage = state.profileData?.profile?.profileImage;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'پروفایل کاربری',
            style: TextStyle(
              fontFamily: 'IRANYekan',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // بخش آواتار با مداد ویرایش
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            (profileImage != null && profileImage.isNotEmpty)
                            ? NetworkImage(profileImage)
                            : null,
                        child: (profileImage == null || profileImage.isEmpty)
                            ? const Icon(
                                Icons.person,
                                size: 54,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      if (state.isUploadingPhoto)
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: state.isUploadingPhoto
                              ? null
                              : _pickAndUploadImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // فیلدهای اطلاعات کاربری (User)
                _buildSectionHeader('اطلاعات حساب کاربری'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _nameCtrl,
                        label: 'نام',
                        icon: Icons.person_outline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _lastNameCtrl,
                        label: 'نام خانوادگی',
                        icon: Icons.person_outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _usernameCtrl,
                  label: 'نام کاربری',
                  icon: Icons.alternate_email,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _phoneCtrl,
                        label: 'شماره تماس',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _emailCtrl,
                        label: 'ایمیل',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _provinceCtrl,
                        label: 'استان',
                        icon: Icons.location_city_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _cityCtrl,
                        label: 'شهر',
                        icon: Icons.location_on_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _birthDateCtrl,
                  label: 'تاریخ تولد',
                  icon: Icons.cake_outlined,
                ),

                const SizedBox(height: 24),
                // فیلدهای اطلاعات تکمیلی و مهارت‌ها (Profile)
                _buildSectionHeader('اطلاعات تکمیلی و مهارت‌ها'),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _educationCtrl,
                  label: 'سطح تحصیلات',
                  icon: Icons.school_outlined,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _skillsCtrl,
                  label: 'مهارت‌ها (با کاما جدا کنید)',
                  icon: Icons.star_border,
                  hintText: 'Flutter, NestJS, Git, UI/UX',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _interestsCtrl,
                  label: 'علاقه‌مندی‌ها (با کاما جدا کنید)',
                  icon: Icons.favorite_border,
                  hintText: 'طراحی، برنامه‌نویسی، مطالعه',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _addressCtrl,
                  label: 'آدرس',
                  icon: Icons.home_outlined,
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _aboutMeCtrl,
                  label: 'درباره من',
                  icon: Icons.info_outline,
                  maxLines: 3,
                ),

                const SizedBox(height: 32),
                // دکمه ذخیره تغییرات
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: state.isSaving ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: state.isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'ذخیره تغییرات',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'IRANYekan',
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'IRANYekan',
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontFamily: 'IRANYekan', fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    );
  }
}
