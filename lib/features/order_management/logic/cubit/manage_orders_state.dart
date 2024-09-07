part of 'manage_orders_cubit.dart';

class ManageOrdersState {
  List<OrderCategory>? categories;
  bool? isLoading;

  ManageOrdersState({this.categories = const [], this.isLoading = false});

  ManageOrdersState copyWith(
      {List<OrderCategory>? categories, bool? isLoading}) {
    return ManageOrdersState(
        categories: categories ?? this.categories,
        isLoading: isLoading ?? this.isLoading);
  }
}
