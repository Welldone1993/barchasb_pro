import '../../domain/entities/weekly_stats_entity.dart';

class WeeklyStatsModel extends WeeklyStatsEntity {
  WeeklyStatsModel({required super.label, required super.view});

  factory WeeklyStatsModel.fromJson(Map<String, dynamic> json) =>
      WeeklyStatsModel(label: json['label'], view: json['views']);
}
