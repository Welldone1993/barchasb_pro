import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home_provider.dart';
import '../widgets/barchasb_subtitle_widget.dart';
import '../widgets/home_scaffold_screen.dart';
import '../widgets/horizontal_list_view_handler.dart';
import '../widgets/search_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Widget buildAdImage(String? url) {
    if (url == null || url.isEmpty) {
      return Image.asset('assets/images/placeholder.png');
    }

    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    return HomeScaffoldScreen(
      body: RefreshIndicator(
        onRefresh: homeNotifier.fetchAll,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0), // در صورت نیاز به فاصله
                child: CustomSearchBar(),
              ),
            ),
            SliverToBoxAdapter(child: BarchasbSubtitle()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: HorizontalListViewHandler(
                title: 'فروشندگان',
                state: homeState.sellers,
                onRetry: homeNotifier.fetchSellers,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            SliverToBoxAdapter(
              child: HorizontalListViewHandler(
                title: 'کارفرمایان',
                state: homeState.employers,
                onRetry: homeNotifier.fetchEmployers,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            SliverToBoxAdapter(
              child: HorizontalListViewHandler(
                title: 'کارجویان',
                state: homeState.jobSeekers,
                onRetry: homeNotifier.fetchJobSeekers,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
