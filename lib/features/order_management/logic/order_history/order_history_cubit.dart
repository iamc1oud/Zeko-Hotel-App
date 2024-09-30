import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/src/material/date.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/all_orders.dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/orders.dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';

import 'package:zeko_hotel_crm/utils/constants.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  late OrderRepository orderRepository;

  OrderHistoryCubit({required this.orderRepository})
      : super(OrderHistoryState()) {
    emit(state.copyWith(
        startTime: DateTime.now().subtract(const Duration(days: 6)),
        endTime: DateTime.now()));
  }

  Future<Either<Exception, AllOrders>> getAllOrders(int pageKey) async {
    var order = await orderRepository.getAllOrders(ListOrdersDTO(
        limit: PAGE_LIMIT.toString(),
        page: pageKey.toString(),
        startTime: state.startTime!.subtract(const Duration(days: 1)),
        endTime: state.endTime!.add(const Duration(days: 1))));

    return order;
  }

  void setDateRange({required DateTimeRange dateRange}) {
    emit(state.copyWith(startTime: dateRange.start, endTime: dateRange.end));
  }
}
