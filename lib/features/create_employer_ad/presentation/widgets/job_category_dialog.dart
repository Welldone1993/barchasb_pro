import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/job_category_model.dart';
import '../providers/job_category_dialog_provider.dart';

class JobCategoryDialog extends ConsumerWidget {
  final List<JobCategoryModel> initialSelected;

  const JobCategoryDialog({
    super.key,
    this.initialSelected = const [],
  });

  static Future<List<JobCategoryModel>?> show(
      BuildContext context, {
        List<JobCategoryModel> initialSelected = const [],
      }) {
    return showDialog<List<JobCategoryModel>>(
      context: context,
      barrierDismissible: true,
      builder: (_) => JobCategoryDialog(initialSelected: initialSelected),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobCategoryDialogProvider(initialSelected));
    final notifier = ref.read(jobCategoryDialogProvider(initialSelected).notifier);
    final isSubCategoryView = state.selectedMainCategory != null;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 580),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // هدر (عنوان + دکمه بازگشت/بستن)
              Row(
                children: [
                  if (isSubCategoryView)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 18),
                      onPressed: notifier.backToMainCategories,
                    ),
                  Expanded(
                    child: Text(
                      isSubCategoryView
                          ? state.selectedMainCategory!.name
                          : 'انتخاب دسته شغلی',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // نوار جستجو
              TextField(
                onChanged: notifier.updateSearch,
                decoration: InputDecoration(
                  hintText: 'جستجو...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // لیست محتوا / وضعیت لودینگ
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.errorMessage != null
                    ? Center(
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
                    : state.filteredList.isEmpty
                    ? const Center(child: Text('موردی یافت نشد'))
                    : ListView.separated(
                  itemCount: state.filteredList.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = state.filteredList[index];

                    if (!isSubCategoryView) {
                      // نمایش دسته‌های اصلی
                      return ListTile(
                        title: Text(item.name),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () => notifier.selectMainCategory(item),
                      );
                    }

                    // نمایش زیردسته‌ها با چک‌باکس (مطابق تصویر)
                    final isChecked = state.selectedSubCategories
                        .any((selected) => selected.id == item.id);

                    return CheckboxListTile(
                      value: isChecked,
                      title: Text(item.name),
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (_) => notifier.toggleSubCategory(item),
                    );
                  },
                ),
              ),

              // دکمه تایید نهایی در صفحه زیردسته‌ها
              if (isSubCategoryView) ...[
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(state.selectedSubCategories);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'ثبت و تایید (${state.selectedSubCategories.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
