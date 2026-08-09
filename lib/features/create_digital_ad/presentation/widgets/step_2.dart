import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/digital_ad_provider.dart';
import '../providers/step_2_provider.dart';

class Step2DigitalAdInfoScreen extends ConsumerStatefulWidget {
  const Step2DigitalAdInfoScreen({super.key});

  @override
  ConsumerState<Step2DigitalAdInfoScreen> createState() =>
      _Step2DigitalAdInfoScreenState();
}

class _Step2DigitalAdInfoScreenState
    extends ConsumerState<Step2DigitalAdInfoScreen> {
  final TextEditingController _skillController = TextEditingController();

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(step2Provider);
    final step2Notifier = ref.read(step2Provider.notifier);
    final notifier = ref.read(digitalAdProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      // ردیف اینپوت و دکمه افزودن
                      Row(
                        children: [
                          // فیلد متنی مهارت
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextField(
                                controller: _skillController,
                                textAlign: TextAlign.right,
                                decoration: const InputDecoration(
                                  hintText: 'مهارت های مورد نیاز',
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
                                onSubmitted: (value) {
                                  step2Notifier.addSkill(value);
                                  _skillController.clear();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // دکمه افزودن
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B5978),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                step2Notifier.addSkill(_skillController.text);
                                _skillController.clear();
                              },
                              child: const Text(
                                'افزودن',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // کادر سفید نمایش مهارت‌ها (Chips)
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 8.0,
                              // فاصله افقی بین چیپ‌ها
                              runSpacing: 8.0,
                              // فاصله عمودی بین ردیف‌های چیپ‌ها
                              alignment: WrapAlignment.start,
                              children: skills.map((skill) {
                                return _buildSkillChip(skill, () {
                                  step2Notifier.removeSkill(skill);
                                });
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // دکمه‌های ناوبری (مرحله قبل و بعد)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2CB4EE),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          notifier.prevStep();
                        },
                        child: const Text(
                          'مرحله قبل',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ویجت سازنده چیپ مهارت
  Widget _buildSkillChip(String title, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A5F), // رنگ سرمه‌ای پس‌زمینه چیپ
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF35B5B), // رنگ قرمز ضربدر
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
