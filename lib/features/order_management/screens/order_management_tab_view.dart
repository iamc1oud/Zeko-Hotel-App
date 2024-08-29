import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/cubit/manage_orders_cubit.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/list_orders/pending_orders_list_view.dart';
import 'package:zeko_hotel_crm/main.dart';

class OrderManagementTabView extends StatefulWidget {
  const OrderManagementTabView({super.key});

  @override
  State<OrderManagementTabView> createState() => _OrderManagementTabViewState();
}

class _OrderManagementTabViewState extends State<OrderManagementTabView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ManageOrdersCubit(
                orderRepository: getIt.get<OrderRepository>())),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Order Management'),
          ),
          body: BlocProvider.value(
            value: context.read<ManageOrdersCubit>(),
            child: const PendingOrdersListView(),
          ),
        );
      }),
    );
  }
}
