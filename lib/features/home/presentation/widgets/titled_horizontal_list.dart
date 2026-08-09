import 'package:flutter/material.dart';

class TitledHorizontalList extends StatelessWidget {
  final String title;
  final double listHeight;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const TitledHorizontalList({
    super.key,
    required this.title,
    required this.listHeight,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
              )
            ],
          ),
        ),
        SizedBox(
          height: listHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            reverse: true, // To show items from right to left
          ),
        ),
      ],
    );
  }
}
