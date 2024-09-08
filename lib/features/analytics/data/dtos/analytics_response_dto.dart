import 'package:equatable/equatable.dart';

class AnalyticsResponseDTO extends Equatable {
  final BudgetMetrics budgetMetrics;

  final num timeSavedInCheckIn;

  const AnalyticsResponseDTO({
    required this.budgetMetrics,
    required this.timeSavedInCheckIn,
  });

  @override
  List<Object?> get props => [budgetMetrics, timeSavedInCheckIn];

  factory AnalyticsResponseDTO.fromJson(Map<String, dynamic> json) {
    return AnalyticsResponseDTO(
      budgetMetrics: BudgetMetrics.fromJson(json['budgetMetrics']),
      timeSavedInCheckIn: json['timeSavedInCheckIn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'budgetMetrics': budgetMetrics.toJson(),
      'timeSavedInCheckIn': timeSavedInCheckIn,
    };
  }
}

class BudgetMetrics extends Equatable {
  final num budgetAchieved;
  final num budgetTarget;

  const BudgetMetrics({
    required this.budgetAchieved,
    required this.budgetTarget,
  });

  @override
  List<Object?> get props => [budgetAchieved, budgetTarget];

  factory BudgetMetrics.fromJson(Map<String, dynamic> json) {
    return BudgetMetrics(
      budgetAchieved: json['budgetAchieved'],
      budgetTarget: json['budgetTarget'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'budgetAchieved': budgetAchieved,
      'budgetTarget': budgetTarget,
    };
  }
}
