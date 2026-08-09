import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'subscription_plans_screen.dart';
import 'transaction_history_card.dart';
import 'wallet_balance_card.dart';

final subscriptionSegmentProvider = StateProvider<int>((ref) => 0);

class CustomSubscriptionSegmentView extends ConsumerWidget {
  const CustomSubscriptionSegmentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(subscriptionSegmentProvider);

    return Column(
      children: [
        _tabs(ref, selectedIndex),
        const SizedBox(height: 16),
        _buildTabWidget(selectedIndex),
      ],
    );
  }

  Widget _tabs(WidgetRef ref, int selectedIndex) => Container(
    height: 100,
    padding: const EdgeInsets.all(4),
    child: Row(
      children: [
        _buildActionItem(
          title: 'اشتراک',
          icon: Icons.inventory_2_outlined,
          isSelected: selectedIndex == 0,
          onTap: () {
            ref.read(subscriptionSegmentProvider.notifier).state = 0;
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          title: 'کیف پول',
          icon: Icons.account_balance_wallet_outlined,
          isSelected: selectedIndex == 1,
          onTap: () {
            ref.read(subscriptionSegmentProvider.notifier).state = 1;
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          title: 'تراکنش‌ها',
          icon: Icons.bar_chart_rounded,
          isSelected: selectedIndex == 2,
          onTap: () {
            ref.read(subscriptionSegmentProvider.notifier).state = 2;
          },
        ),
      ],
    ),
  );

  Widget _buildTabWidget(int selectedIndex) => IndexedStack(
    index: selectedIndex,
    children: const [
      // Center(child: Text('data1')),
      SubscriptionPlansCard(),
      // Center(child: Text('data2')),
      WalletBalanceCard(),
      // Center(child: Text('data3')),
      TransactionHistoryCard(),
    ],
  );

  Widget _buildActionItem({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    // رنگ‌ها بر اساس انتخاب شدن یا نشدن تغییر می‌کنند
    final bgColor = isSelected ? const Color(0xFF1E4064) : Colors.white;
    final contentColor = isSelected ? Colors.white : const Color(0xFF1E4064);

    return Expanded(
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        elevation: isSelected ? 4 : 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 32, color: contentColor),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
