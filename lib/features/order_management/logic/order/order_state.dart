part of 'order_cubit.dart';

class OrderState {
  OrderCategory? order;
  List<Order$Items>? items;
  bool? isLoading;

  OrderState({this.order, this.items = const [], this.isLoading = false});

  OrderState copyWith(
      {OrderCategory? order, List<Order$Items>? items, bool? isLoading}) {
    return OrderState(
        isLoading: isLoading ?? this.isLoading,
        order: order ?? this.order,
        items: items ?? this.items);
  }
}

class Order$Items extends Equatable {
  final int id;
  final OrderItem item;
  final int quantity;
  bool? isSelected;

  Order$Items(
      {required this.id,
      required this.item,
      required this.quantity,
      this.isSelected = true});

  @override
  List<Object?> get props => [id];

  Order$Items copyWith({bool? isSelected}) {
    return Order$Items(
        id: id,
        item: item,
        quantity: quantity,
        isSelected: isSelected ?? this.isSelected);
  }
}
