import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/employer_ad_provider.dart';
import '../providers/step_2_provider.dart';

class Step2JobInfoScreen extends ConsumerWidget {
  const Step2JobInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(step2Provider);
    final notifier = ref.read(employerAdProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ردیف 1
            Row(
              children: [
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'نوع همکاری',
                    value: formData.cooperationType,
                    items: ['تمام وقت', 'پاره وقت', 'پروژه‌ای', 'کارآموزی'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(cooperationType: val),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'جنسیت',
                    value: formData.gender,
                    items: ['مهم نیست', 'مرد', 'زن'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(gender: val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ردیف 2
            Row(
              children: [
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'سابقه',
                    value: formData.experience,
                    items: ['کمتر از ۱ سال', '۱ تا ۳ سال', '۳ تا ۶ سال', 'بیشتر از ۶ سال'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(experience: val),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'شیوه پرداخت',
                    value: formData.paymentMethod,
                    items: ['ماهیانه', 'روزانه', 'ساعتی', 'پروژه‌ای'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(paymentMethod: val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ردیف 3
            Row(
              children: [
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'حداقل حقوق',
                    value: formData.minSalary,
                    items: ['وزارت کار', '۱۰ میلیون', '۱۵ میلیون', '۲۰ میلیون به بالا'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(minSalary: val),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'حداکثر حقوق',
                    value: formData.maxSalary,
                    items: ['۱۵ میلیون', '۲۰ میلیون', '۳۰ میلیون', 'توافقی'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(maxSalary: val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ردیف 4
            Row(
              children: [
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'ساعت شروع کار',
                    value: formData.startTime,
                    items: ['۰۸:۰۰', '۰۹:۰۰', '۱۰:۰۰'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(startTime: val),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'ساعت پایان کار',
                    value: formData.endTime,
                    items: ['۱۶:۰۰', '۱۷:۰۰', '۱۸:۰۰'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(endTime: val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ردیف 5
            Row(
              children: [
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'وضعیت سربازی',
                    value: formData.militaryStatus,
                    items: ['پایان خدمت / معافیت', 'در حال خدمت', 'مهم نیست'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(militaryStatus: val),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSelector(
                    context: context,
                    title: 'سایر ویژگی ها',
                    value: formData.otherFeatures,
                    items: ['بیمه', 'پاداش', 'پورسانت', 'سرویس رفت و برگشت'],
                    onSelected: (val) => ref.read(step2Provider.notifier).updateData(otherFeatures: val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // دکمه های مرحله قبل و بعد
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF32BDF6), // آبی روشن
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        notifier.prevStep();
                      },
                      child: const Text('مرحله قبل', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B5978), // آبی تیره
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        notifier.nextStep();
                      },
                      child: const Text('مرحله بعد', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ویجت سفارشی برای دکمه‌های کشویی
  Widget _buildSelector({
    required BuildContext context,
    required String title,
    required String value,
    required List<String> items,
    required Function(String) onSelected,
  }) {
    return GestureDetector(
      onTap: () => _showSelectionDialog(context, title, items, onSelected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey, size: 20),
            Expanded(
              child: Text(
                value.isEmpty ? title : value,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: value.isEmpty ? Colors.grey : Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دیالوگ انتخاب مقادیر
  void _showSelectionDialog(
      BuildContext context,
      String title,
      List<String> items,
      Function(String) onSelected
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: const Color(0xFFF5F6F8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('انتخاب $title', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: items.length > 5 ? 250 : null, // تنظیم ارتفاع برای لیست‌های طولانی
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          onSelected(items[index]);
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            items[index],
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: Colors.blueGrey),
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
