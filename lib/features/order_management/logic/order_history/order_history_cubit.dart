import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/all_orders.dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/orders.dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';

import 'package:zeko_hotel_crm/utils/constants.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  late OrderRepository orderRepository;

  OrderHistoryCubit({required this.orderRepository})
      : super(OrderHistoryState());

  Future<Either<Exception, AllOrders>> getAllOrders(int pageKey) async {
    var order = await orderRepository.getAllOrders(ListOrdersDTO(
        limit: PAGE_LIMIT.toString(),
        page: pageKey.toString(),
        startTime: DateTime.now().subtract(const Duration(days: 7)),
        endTime: DateTime.now().add(const Duration(days: 1))));

    return order;
  }
}
