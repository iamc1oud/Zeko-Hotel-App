part of 'manage_orders_cubit.dart';

class ManageOrdersState {
  List<Order> escalatedOrders = [];

  ManageOrdersState({
    this.escalatedOrders = const [],
  });

  ManageOrdersState copyWith({List<Order>? escalatedOrders}) {
    return ManageOrdersState(
        escalatedOrders: escalatedOrders ?? this.escalatedOrders);
  }
}
