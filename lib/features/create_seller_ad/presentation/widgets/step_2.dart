import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/seller_ad_provider.dart';
import '../providers/step_2_provider.dart';

class Step2SellerAdInfoScreen extends ConsumerWidget {
  const Step2SellerAdInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(step2Provider);
    final step2Notifier = ref.read(step2Provider.notifier);
    final notifier = ref.read(sellerAdProvider.notifier);
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // ردیف ۱: استان و شهر
                        Row(
                          children: [
                            Expanded(
                              child: _buildSelector(
                                context,
                                'استان',
                                state.province,
                                ['تهران', 'اصفهان', 'خراسان رضوی'],
                                (val) =>
                                    step2Notifier.updateField('province', val),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSelector(
                                context,
                                'شهر',
                                state.city,
                                ['تهران', 'مشهد', 'اصفهان', 'شیراز'],
                                (val) => step2Notifier.updateField('city', val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ردیف ۲: وضعیت و کاربرد
                        Row(
                          children: [
                            Expanded(
                              child: _buildSelector(
                                context,
                                'وضعیت',
                                state.condition,
                                ['نو', 'در حد نو', 'کارکرده'],
                                (val) =>
                                    step2Notifier.updateField('condition', val),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSelector(
                                context,
                                'کاربرد',
                                state.usage,
                                ['خانگی', 'صنعتی', 'تجاری'],
                                (val) =>
                                    step2Notifier.updateField('usage', val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ردیف ۳: قیمت و مقطوع
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                'قیمت به تومان',
                                (val) =>
                                    step2Notifier.updateField('price', val),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildCheckbox(
                                'مقطوع',
                                state.isFixedPrice,
                                (val) => step2Notifier.updateField(
                                  'isFixedPrice',
                                  val,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ردیف ۴: معاوضه و گارانتی
                        Row(
                          children: [
                            Expanded(
                              child: _buildCheckbox(
                                'معاوضه',
                                state.isExchangeable,
                                (val) => step2Notifier.updateField(
                                  'isExchangeable',
                                  val,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildCheckbox(
                                'گارانتی دارد',
                                state.hasWarranty,
                                (val) => step2Notifier.updateField(
                                  'hasWarranty',
                                  val,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ردیف ۵: امکان ارسال و ویژگی‌ها
                        Row(
                          children: [
                            Expanded(
                              child: _buildCheckbox(
                                'امکان ارسال دارد',
                                state.canShip,
                                (val) =>
                                    step2Notifier.updateField('canShip', val),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    _showOtherFeaturesDialog(context, ref),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'ویژگی ها و امکانات',
                                      style: TextStyle(
                                        color: Color(0xFFA5B2C4),
                                        fontSize: 14,
                                      ),
                                    ),
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

                // دکمه‌های پایین (مرحله قبل و بعد)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2CB4EE), // آبی روشن
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => notifier.prevStep(),
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
                        }, // مرحله بعد
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
      ),
    );
  }

  // --- ویجت‌های کمکی ---

  Widget _buildSelector(
    BuildContext context,
    String hint,
    String value,
    List<String> items,
    Function(String) onSelected,
  ) {
    return GestureDetector(
      onTap: () {
        // باز کردن یک دیالوگ ساده برای انتخاب دراپ‌داون‌ها
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFFF5F6F8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items
                  .map(
                    (e) => ListTile(
                      title: Text(
                        e,
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Color(0xFF3B5978)),
                      ),
                      onTap: () {
                        onSelected(e);
                        Navigator.pop(ctx);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3B5978)),
            Text(
              value.isEmpty ? hint : value,
              style: TextStyle(
                color: value.isEmpty
                    ? const Color(0xFFA5B2C4)
                    : const Color(0xFF3B5978),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, Function(String) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        textAlign: TextAlign.right,
        onChanged: onChanged,
        style: const TextStyle(color: Color(0xFF3B5978), fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFA5B2C4), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value
                    ? const Color(0xFF3B5978)
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: value
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF3B5978),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOtherFeaturesDialog(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(step2Provider.notifier);

    showDialog(
      context: context,
      builder: (ctx) => _CustomDialogLayout(
        title: 'سایر ویژگی ها و امکانات',
        children: [
          _DialogDropdown(
            hint: 'نوع ابزار',
            items: const ['برقی', 'دستی', 'بادی', 'شارژی'],
            onSelected: (v) => notifier.updateField('toolType', v),
          ),
          _DialogTextField(
            hint: 'برند / تولیدکننده',
            onChanged: (v) => notifier.updateField('brand', v),
          ),
          _DialogTextField(
            hint: 'مدل',
            onChanged: (v) => notifier.updateField('model', v),
          ),
          _DialogTextField(
            hint: 'توان / قدرت (وات)',
            onChanged: (v) => notifier.updateField('power', v),
          ),
          _DialogTextField(
            hint: 'مشخصات فنی',
            onChanged: (v) => notifier.updateField('technicalSpecs', v),
          ),
          _DialogTextField(
            hint: 'اقلام همراه',
            onChanged: (v) => notifier.updateField('includedItems', v),
          ),
          _DialogTextField(
            hint: 'مدت گارانتی (ماه)',
            onChanged: (v) => notifier.updateField('warrantyMonths', v),
          ),
        ],
      ),
    );
  }
}

// --- ویجت پایه برای ظاهر یکپارچه دیالوگ‌ها ---
class _CustomDialogLayout extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _CustomDialogLayout({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF5F6F8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // هدر (دکمه X و تایتل)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF3B5978),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5252),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
              ),
              // محتوای اسکرول‌شونده دیالوگ
              Flexible(
                child: SingleChildScrollView(child: Column(children: children)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ویجت‌های داخلی مخصوص دیالوگ ویژگی‌ها
class _DialogTextField extends StatelessWidget {
  final String hint;
  final Function(String) onChanged;

  const _DialogTextField({required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        textAlign: TextAlign.right,
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

class _DialogDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final Function(String) onSelected;

  const _DialogDropdown({
    required this.hint,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // باز شدن لیست گزینه‌ها
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3B5978)),
            Text(
              hint,
              style: const TextStyle(color: Color(0xFFA5B2C4), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
