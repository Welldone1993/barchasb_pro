class DigitalAdEnhancementsEntity {
  final bool isSpecial;
  final DateTime? specialStartDate;
  final DateTime? specialEndDate;
  final bool isLadder;
  final List<dynamic> ladders;

  const DigitalAdEnhancementsEntity({
    required this.isSpecial,
    required this.specialStartDate,
    required this.specialEndDate,
    required this.isLadder,
    required this.ladders,
  });
}
