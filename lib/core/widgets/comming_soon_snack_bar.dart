import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) => _customSnackBar();

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_customSnackBar());
  }

  SnackBar _customSnackBar() => SnackBar(
    content: Text(
      title ?? 'به زودی...',
      style: TextStyle(fontFamily: 'Vazirmatn'),
    ),
    duration: Duration(seconds: 2),
  );
}
