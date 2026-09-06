class EnhancementsEntity {
  final bool isSpecial;
  final DateTime? specialStartDate;
  final DateTime? specialEndDate;
  final bool isLadder;
  final List<dynamic> ladders;

  const EnhancementsEntity({
    required this.isSpecial,
    this.specialStartDate,
    this.specialEndDate,
    required this.isLadder,
    this.ladders = const [],
  });
}
