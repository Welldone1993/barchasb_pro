import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'employer_ads.dart';
import 'filter_bottom_sheet.dart';
import 'job_seeker_ads.dart';
import 'seller_ads.dart';

final adSegmentProvider = StateProvider<int>((ref) => 0);

class CustomAdSegmentView extends ConsumerWidget {
  const CustomAdSegmentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(adSegmentProvider);

    return Column(
      children: [
        _header(context, ref, selectedIndex),
        const SizedBox(height: 16),
        Expanded(child: _buildTabWidget(selectedIndex)),
      ],
    );
  }

  Widget _header(BuildContext context, WidgetRef ref, int selectedIndex) => Row(
    children: [
      Expanded(child: _tabs(ref, selectedIndex)),
      const SizedBox(width: 8),
      _filterButton(context),
    ],
  );

  Widget _tabs(WidgetRef ref, int selectedIndex) => Container(
    height: 48,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        _buildTabItem(
          ref,
          title: 'کارجو',
          index: 0,
          selectedIndex: selectedIndex,
        ),
        _buildTabItem(
          ref,
          title: 'کارفرما',
          index: 1,
          selectedIndex: selectedIndex,
        ),
        _buildTabItem(
          ref,
          title: 'آگهی ها',
          index: 2,
          selectedIndex: selectedIndex,
        ),
      ],
    ),
  );

  Widget _filterButton(BuildContext context) => Container(
    height: 48,
    width: 48,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: IconButton(
      icon: const Icon(Icons.tune, color: Color(0xFF1C3A5A)),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          // مهم: برای اینکه باتم‌شیت بتواند تمام صفحه شود
          backgroundColor: Colors.transparent,
          // برای دیده شدن گوشه‌های گرد
          builder: (context) {
            return const DigitalAdsFilterBottomSheet();
          },
        );
      },
    ),
  );

  Widget _buildTabWidget(int selectedIndex) => IndexedStack(
    index: selectedIndex,
    children: const [JobSeekerAdsView(), EmployerAdsView(), SellerAdsView()],
  );

  Widget _buildTabItem(
    WidgetRef ref, {
    required String title,
    required int index,
    required int selectedIndex,
  }) {
    final isSelected = index == selectedIndex;
    final activeColor = const Color(0xFF1E4064);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(adSegmentProvider.notifier).state = index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : activeColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
