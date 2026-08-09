import 'package:equatable/equatable.dart';

class EmployerAdEntity extends Equatable {
  final String id;
  final String name;
  final String? category;
  final String? state;
  final String? city;
  final List<String> skills;
  final double ratingAverage;
  final String? imageUrl;

  const EmployerAdEntity({
    required this.id,
    required this.name,
    this.category,
    this.state,
    this.city,
    this.skills = const [],
    this.ratingAverage = 0.0,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    state,
    city,
    skills,
    ratingAverage,
    imageUrl,
  ];
}
