import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/work_space_stats_provider.dart';

class WorkSpaceStatsSlide extends ConsumerWidget {
  const WorkSpaceStatsSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(workSpaceStatsProvider);

    return statsState.weeklyStats.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          Center(child: Text('خطا در دریافت اطلاعات$error')),
      data: (statsData) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [...statsData.map((e) => Text(e.label))]),
      ),
    );
  }
}
