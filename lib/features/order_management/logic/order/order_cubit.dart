import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/orders.dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders_dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/manage_orders/manage_orders_cubit.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/alerts.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  late OrderRepository orderRepository;
  late ManageOrdersCubit manageOrdersCubit;

  OrderCubit({required this.orderRepository, required this.manageOrdersCubit})
      : super(OrderState());

  set setOrder(OrderCategory order) {
    var items = List<Order$Items>.empty(growable: true);

    // Set order items
    for (var i in order.items) {
      items.add(Order$Items(id: i.id, item: i, quantity: i.quantity));
    }

    emit(state.copyWith(order: order, items: items));
  }

  void toggleItemCheck(bool v, Order$Items item) {
    // Ensure state.items is not null and find the index of the item
    final items = state.items ?? [];
    final index = items.indexWhere((d) => d == item);

    if (index != -1) {
      // Create a copy of the item with the updated isSelected value
      final updatedItem = items[index].copyWith(isSelected: v);

      // Create a copy of the items list with the updated item
      final updatedItems = List<Order$Items>.from(items)..[index] = updatedItem;

      // Emit the new state with the updated items list
      emit(state.copyWith(items: updatedItems));
    } else {
      logger.d('Item not found');
    }
  }

  Future acceptOrder() async {
    // Show loading state
    emit(state.copyWith(isLoading: true));

    // Check if all items are selected
    bool allItemsSelected = state.items!.every((item) => item.isSelected!);

    if (allItemsSelected) {
      var response = await orderRepository.acceptOrder(
        AcceptOrderDTO(orderId: state.order!.id),
      );

      response.fold((l) {
        // Handle error
        emit(state.copyWith(isLoading: false));
      }, (r) {
        // Show success message and refresh list
        showSnackbar(r.message);
        emit(state.copyWith(isLoading: false));
        manageOrdersCubit.getPendingOrders();
      });
    } else {
      var partialItems =
          state.items!.where((item) => item.isSelected!).toList();

      var command = AcceptOrderDTO(
        orderId: state.order!.id,
        items: partialItems.map((e) => e.id).toList(),
      );

      var partialResponse = await orderRepository.partialAcceptOrder(command);

      partialResponse.fold((l) {
        // Handle error for partial acceptance
        emit(state.copyWith(isLoading: false));
      }, (r) {
        // Show success message and refresh list for partial order
        showSnackbar(r.message);
        emit(state.copyWith(isLoading: false));
        manageOrdersCubit.getPendingOrders();
      });
    }
  }

  Future rejectOrder(String reason) async {
    var command = RejectOrderDTO(orderId: state.order!.id, reason: reason);

    var response = await orderRepository.rejectOrder(command);

    response.fold((l) {
      // Handle error for partial acceptance
      emit(state.copyWith(isLoading: false));
    }, (r) {
      // Show success message and refresh list for partial order
      showSnackbar(r.message);
      emit(state.copyWith(isLoading: false));
      manageOrdersCubit.getPendingOrders();
    });
  }
}
