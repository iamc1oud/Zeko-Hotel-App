part of 'manage_orders_cubit.dart';

class ManageOrdersState {
  List<Order> escalatedOrders = [];

  List<Order> otherOrders = [];

  ManageOrdersState({
    this.escalatedOrders = const [],
    this.otherOrders = const [],
  });

  ManageOrdersState copyWith(
      {List<Order>? escalatedOrders, List<Order>? otherOrders}) {
    return ManageOrdersState(
        otherOrders: otherOrders ?? this.otherOrders,
        escalatedOrders: escalatedOrders ?? this.escalatedOrders);
  }
}
