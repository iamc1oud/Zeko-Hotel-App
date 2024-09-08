part of 'analytics_cubit.dart';

// ignore: must_be_immutable
class AnalyticsState {
  BudgetMetrics? budget;

  DateTime? startTime;
  DateTime? endTime;

  num? totalRevenue;
  num? revenueFromPlatform;
  num? missedRevenue;
  Duration? timeSaved;

  AnalyticsState(
      {this.budget,
      this.startTime,
      this.endTime,
      this.timeSaved,
      this.missedRevenue,
      this.totalRevenue,
      this.revenueFromPlatform});

  AnalyticsState copyWith(
      {BudgetMetrics? budget,
      DateTime? startTime,
      DateTime? endTime,
      num? totalRevenue,
      num? revenueFromPlatform,
      num? missedRevenue,
      Duration? timeSaved}) {
    return AnalyticsState(
        timeSaved: timeSaved ?? this.timeSaved,
        missedRevenue: missedRevenue ?? this.missedRevenue,
        revenueFromPlatform: revenueFromPlatform ?? this.revenueFromPlatform,
        totalRevenue: totalRevenue ?? this.totalRevenue,
        budget: budget ?? this.budget,
        endTime: endTime ?? this.endTime,
        startTime: startTime ?? this.startTime);
  }
}
