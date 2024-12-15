import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/core/date_parser.dart';
import 'package:zeko_hotel_crm/features/analytics/data/dtos/analytics_dto.dart';
import 'package:zeko_hotel_crm/features/analytics/data/dtos/analytics_response_dto.dart';
import 'package:zeko_hotel_crm/features/analytics/data/repository/analytics_repository.dart';
import 'package:zeko_hotel_crm/main.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  late AnalyticsRepository analyticsRepository;

  AnalyticsCubit({required this.analyticsRepository})
      : super(AnalyticsState()) {
    emit(state.copyWith(
        startTime: DateTime.now().subtract(const Duration(days: 30)),
        endTime: DateTime.now()));
  }

  getAnalytics({DateTimeRange? dateRange}) async {
    if (dateRange != null) {
      emit(state.copyWith(startTime: dateRange.start, endTime: dateRange.end));
    }
    var response = await analyticsRepository.getHotelAnalytics(AnalyticsDTO(
        startTime: state.startTime.toString().forAPI(),
        endTime: state.endTime.toString().forAPI()));

    response.fold((l) {
      logger.d(l.toString());
    }, (r) {
      emit(state.copyWith(
          budget: r.data?.budgetMetrics,
          totalRevenue: 1000,
          missedRevenue: 900,
          timeSaved: Duration(days: 1, hours: 2, minutes: 19),
          revenueFromPlatform: 1255));
    });
  }
}
