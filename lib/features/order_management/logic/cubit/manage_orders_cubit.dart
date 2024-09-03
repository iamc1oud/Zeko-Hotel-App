import 'package:bloc/bloc.dart';

import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders_dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';

part 'manage_orders_state.dart';

class ManageOrdersCubit extends Cubit<ManageOrdersState> {
  late OrderRepository orderRepository;

  ManageOrdersCubit({required this.orderRepository})
      : super(ManageOrdersState());

  Future getPendingOrders() async {
    var result = await orderRepository.getPendingOrders();

    List<Order> otherOrders = List.empty(growable: true);

    // Loop over each category and add to list
    result.data?.otherCategories.forEach((key, orders) {
      print("KEY: $key");

      otherOrders.addAll(orders);
    });

    // Loop over other order categories
    emit(state.copyWith(
        escalatedOrders: result.data?.escalatedOrders,
        otherOrders: otherOrders));
  }
}
