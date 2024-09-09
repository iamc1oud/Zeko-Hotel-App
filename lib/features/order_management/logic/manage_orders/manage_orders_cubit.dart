import 'package:bloc/bloc.dart';

import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders_dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';
import 'package:zeko_hotel_crm/main.dart';

part 'manage_orders_state.dart';

class ManageOrdersCubit extends Cubit<ManageOrdersState> {
  late OrderRepository orderRepository;

  ManageOrdersCubit({required this.orderRepository})
      : super(ManageOrdersState());

  Future getPendingOrders({bool? polling = false}) async {
    if (!polling!) {
      emit(state.copyWith(isLoading: true));
    }

    var result = await orderRepository.getPendingOrders();

    result.fold((l) {}, (r) {
      // Filter the orders
      List<OrderCategory> allOrders = [];

      r.data!.categories.forEach((key, value) {
        allOrders.addAll(value);
      });

      emit(state.copyWith(categories: allOrders, isLoading: false));
    });
  }
}
