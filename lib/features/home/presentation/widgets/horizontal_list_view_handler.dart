// lib/features/home/presentation/widgets/horizontal_list_view_handler.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/ad_entity.dart';
import 'user_card.dart';

class HorizontalListViewHandler extends StatelessWidget {
  final String title;
  final AsyncValue<List<AdEntity>> state;
  final VoidCallback onRetry;

  const HorizontalListViewHandler({
    super.key,
    required this.title,
    required this.state,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              TextButton(onPressed: () {}, child: const Text('مشاهده همه')),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: state.when(
            data: (list) => list.isEmpty
                ? const Center(child: Text('موردی یافت نشد'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: list.length,
                    itemBuilder: (context, index) =>
                        HorizontalAdCard(ad: list[index]),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: onRetry,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
