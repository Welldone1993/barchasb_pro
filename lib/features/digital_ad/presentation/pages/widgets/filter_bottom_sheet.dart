import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // متغیرهایی برای نگهداری وضعیت فیلترهای انتخاب شده
  String? selectedTime;
  String? selectedJobType;
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    // استفاده از Directionality برای راست‌چین بودن
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height:
            MediaQuery.of(context).size.height *
            0.9, // ارتفاع باتم‌شیت (۹۰٪ صفحه)
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // هدر: دکمه بستن و عنوان
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'فیلتر ها :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),

            // محتوای قابل اسکرول فیلترها
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // فیلد جستجو
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'جستجوی کلمه ...',
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // بخش مدت زمان
                    _buildSectionHeader('مدت زمان'),
                    _buildRadioGrid(
                      options: ['امروز', 'این هفته', 'این ماه', 'سال اخیر'],
                      groupValue: selectedTime,
                      onChanged: (val) => setState(() => selectedTime = val),
                    ),
                    const Divider(height: 32),

                    // بخش نوع کار
                    _buildSectionHeader('نوع کار'),
                    _buildRadioGrid(
                      options: ['تمام وقت', 'پاره وقت', 'دورکاری', 'کارآموزی'],
                      groupValue: selectedJobType,
                      onChanged: (val) => setState(() => selectedJobType = val),
                    ),
                    const Divider(height: 32),

                    // بخش دسته شغل‌ها (چک‌باکس)
                    _buildSectionHeader('دسته شغل ها'),
                    _buildCheckboxGrid(
                      options: ['وب', 'طراحی ui', 'مالی', 'بازاریابی'],
                      selectedOptions: selectedCategories,
                      onChanged: (val, isSelected) {
                        setState(() {
                          if (isSelected) {
                            selectedCategories.add(val);
                          } else {
                            selectedCategories.remove(val);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // فیلد افزودن مهارت
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'افزودن مهارت ...',
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.black54,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // دکمه اعمال فیلتر در پایین (اختیاری - بر اساس نیاز خودتان اضافه کنید)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: اعمال فیلترها و بستن صفحه
                  Navigator.pop(context, {/* دیتای فیلتر */});
                },
                child: const Text('اعمال فیلتر'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ویجت کمکی برای هدر بخش‌ها
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  // ویجت کمکی برای گرید گزینه‌های رادیویی (تک انتخابی)
  Widget _buildRadioGrid({
    required List<String> options,
    required String? groupValue,
    required Function(String) onChanged,
  }) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((option) {
        bool isSelected = groupValue == option;
        return GestureDetector(
          onTap: () => onChanged(option),
          child: Container(
            width:
                (MediaQuery.of(context).size.width - 52) / 2, // دو ستونه کردن
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(option, style: const TextStyle(fontSize: 14)),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ویجت کمکی برای گرید گزینه‌های چک‌باکسی (چند انتخابی)
  Widget _buildCheckboxGrid({
    required List<String> options,
    required List<String> selectedOptions,
    required Function(String, bool) onChanged,
  }) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((option) {
        bool isSelected = selectedOptions.contains(option);
        return GestureDetector(
          onTap: () => onChanged(option, !isSelected),
          child: Container(
            width: (MediaQuery.of(context).size.width - 52) / 2,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(option, style: const TextStyle(fontSize: 14)),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
