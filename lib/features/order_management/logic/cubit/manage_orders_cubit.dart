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

    emit(state.copyWith(escalatedOrders: result.data?.escalatedOrders));
  }
}
