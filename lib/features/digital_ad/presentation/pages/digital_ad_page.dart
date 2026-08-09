import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/digital_ad_entity.dart';
import '../providers/digital_ads_provider.dart';
import 'widgets/digital_ad_card.dart';
import 'widgets/filter_bottom_sheet.dart';

class DigitalAdPage extends ConsumerWidget {
  const DigitalAdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(digitalAdsProvider);
    return Column(
      children: [
        _buildSearchBar(context, ref),
        Expanded(
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _errorButton(e, ref),
            data: (ads) => SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () =>
                    ref.read(digitalAdsProvider.notifier).refresh(),
                child: _list(ads),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _list(List<CreateDigitalAdEntity> ads) => ListView.separated(
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    itemCount: ads.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (context, index) {
      return DigitalAdCard(digitalAd: ads[index]);
    },
  );

  Widget _errorButton(Object e, WidgetRef ref) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(e.toString()),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => ref.read(digitalAdsProvider.notifier).refresh(),
          child: const Text('تلاش مجدد'),
        ),
      ],
    ),
  );

  Widget _buildSearchBar(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: (value) {
                // 🔴 با صدا زدن این متد، state خودکار به loading می‌رود و دیتا از API گرفته می‌شود
                ref
                    .read(digitalAdsProvider.notifier)
                    .fetchDigitalAds(search: value);
              },
              decoration: InputDecoration(
                hintText: 'جستجو در آگهی‌ها...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // دکمه فیلتر
        InkWell(
          onTap: () => _showFilterDialog(context, ref),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.tune, color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FilterBottomSheet();
      },
    );
  }

  Padding _asd(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'فیلتر آگهی‌ها',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // در اینجا می‌توانید تنظیمات فیلتر را قرار دهید
          // مثلا Dropdown یا Checkbox که به پروایدرهای دیگری متصل هستند
          const Text('دسته‌بندی (مثال)'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('طراحی وب'),
                selected: true,
                onSelected: (v) {},
              ),
              ChoiceChip(
                label: const Text('برنامه‌نویسی'),
                selected: false,
                onSelected: (v) {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // اعمال فیلتر و بستن دیالوگ
                Navigator.pop(context);
              },
              child: const Text('اعمال فیلتر'),
            ),
          ),
        ],
      ),
    );
  }
}
