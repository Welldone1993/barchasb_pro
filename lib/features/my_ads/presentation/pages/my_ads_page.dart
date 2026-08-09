import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAdsPage extends ConsumerWidget {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Center(
      child: Text('MyAdsPage', style: TextStyle(color: theme.primaryColor)),
    );
  }
}
