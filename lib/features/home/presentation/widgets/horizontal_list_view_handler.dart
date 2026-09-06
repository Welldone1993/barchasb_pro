import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/ad_entity.dart';
import 'user_card.dart';

class HorizontalListViewHandler extends StatelessWidget {
  final String title;
  final AsyncValue<List<AdEntity>> state;
  final VoidCallback onRetry;
  final Function(String id) onDetailsTap;

  const HorizontalListViewHandler({
    super.key,
    required this.title,
    required this.state,
    required this.onRetry,
    required this.onDetailsTap,
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
                    itemBuilder: (context, index) => HorizontalAdCard(
                      ad: list[index],
                      onDetailsTap: onDetailsTap,
                    ),
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
