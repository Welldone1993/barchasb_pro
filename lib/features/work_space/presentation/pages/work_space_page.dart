import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/work_space_ads_slide.dart';
import '../widgets/work_space_stats_slide.dart';

final selectedSlideProvider = StateProvider<int>((ref) => 0);

class WorkSpacePage extends ConsumerWidget {
  const WorkSpacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedSlideProvider);
    return SizedBox(
      height: 600,
      child: Column(
        children: [
          Expanded(child: _slideContent(selectedIndex)),
          AnimatedSmoothIndicator(
            activeIndex: selectedIndex,
            count: 2,
            effect: SlideEffect(),
            onDotClicked: (index) {
              ref.read(selectedSlideProvider.notifier).state = index;
            },
          ),
        ],
      ),
    );
  }

  Widget _slideContent(int index) {
    switch (index) {
      case 0:
        return WorkSpaceAdsSlide();
      case 1:
        return WorkSpaceStatsSlide();
      default:
        return const SizedBox.shrink();
    }
  }
}
