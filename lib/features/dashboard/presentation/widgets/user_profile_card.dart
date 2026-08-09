import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/dashboard_provider.dart';

class UserProfileCard extends ConsumerWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(dashboardProvider);
    final theme = Theme.of(context);
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: userState.when(
        data: (user) => Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xff436181),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 28, backgroundImage: NetworkImage(user.id)),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name} ${user.lastName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Spacer(),
                      Text(
                        user.role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Material(
                color: Theme.of(
                  context,
                ).secondaryHeaderColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
                child: IconButton(
                  icon: Icon(Icons.edit_outlined, size: 20),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        loading: () => const _LoadingShimmer(),
        error: (error, stackTrace) => Center(
          child: Column(
            children: [
              Text('خطا در دریافت اطلاعات'),
              ElevatedButton(
                onPressed: () =>
                    ref.read(dashboardProvider.notifier).fetchUser(),
                child: const Text('تلاش مجدد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20, width: 150, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 16, width: 100, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const CircleAvatar(radius: 28, backgroundColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
