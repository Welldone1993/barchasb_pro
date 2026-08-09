import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showBack;
  final AppBar? appBar;

  const AppScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.title,
    this.appBar,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:
        appBar ??
        AppBar(
          title: Text(title ?? ''),
          leading: showBack
              ? IconButton.outlined(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                  color: Theme.of(context).colorScheme.onSecondary,
                )
              : null,
        ),
    body: Padding(padding: const EdgeInsets.all(16.0), child: body),
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    backgroundColor: const Color(0xFF1E3A5F),
  );
}
