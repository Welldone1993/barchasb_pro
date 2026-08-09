// lib/core/utils/time_ago.dart

import 'package:flutter/material.dart';

class TimeAgoWidget extends StatelessWidget {
  final DateTime dateTime;

  const TimeAgoWidget({super.key, required this.dateTime});

  String _format(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return 'همین الان';
    if (diff.inMinutes < 60) return '${diff.inMinutes} دقیقه پیش';
    if (diff.inHours < 24) return '${diff.inHours} ساعت پیش';
    if (diff.inDays == 1) return 'دیروز';
    if (diff.inDays <= 30) return '${diff.inDays} روز پیش';

    final months = (diff.inDays / 30).floor();
    if (months < 12) return '$months ماه پیش';

    final years = (diff.inDays / 365).floor();
    return '$years سال پیش';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A5F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _format(dateTime),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Vazirmatn',
        ),
      ),
    );
  }
}
