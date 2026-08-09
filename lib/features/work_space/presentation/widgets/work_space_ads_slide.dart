import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/work_space_ads_provider.dart';
import 'work_space_ad_card.dart';

class WorkSpaceAdsSlide extends ConsumerStatefulWidget {
  const WorkSpaceAdsSlide({super.key});

  @override
  ConsumerState<WorkSpaceAdsSlide> createState() => _WorkSpaceAdsSlideState();
}

class _WorkSpaceAdsSlideState extends ConsumerState<WorkSpaceAdsSlide> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adsState = ref.watch(workSpaceAdsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(workSpaceAdsProvider.notifier).refresh(),
      child: adsState.when(
        data: (ads) {
          if (ads.isEmpty) {
            return const Center(child: Text('هیچ آگهی یافت نشد.'));
          }

          return ListView.builder(
            itemCount: ads.length,
            itemBuilder: (context, index) {
              final ad = ads[index];
              return WorkSpaceAdCard(
                ad: ad,
                onDownPressed: _nextPage,
                onUpPressed: _previousPage,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('خطا در دریافت اطلاعات: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(workSpaceAdsProvider.notifier).refresh(),
                child: const Text('تلاش مجدد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
