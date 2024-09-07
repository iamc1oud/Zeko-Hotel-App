import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/cubit/manage_orders_cubit.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/list_orders/order_item_card.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/widgets.dart';

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
          body: FutureBuilder(
              future: context.read<ManageOrdersCubit>().getPendingOrders(),
              builder: (_, __) {
                return BlocBuilder<ManageOrdersCubit, ManageOrdersState>(
                  builder: (context, orderState) {
                    if (orderState.isLoading == true) {
                      return const Loading();
                    }

                    return CustomScrollView(
                      slivers: [
                        // NOTE: Can add something interesting here
                        // const SliverAppBar(
                        //   title: Text('Pending Orders'),
                        //   floating: true,
                        // ),
                        SliverList.builder(
                          itemBuilder: (context, index) {
                            return OrderItemCard(
                                order: orderState.categories!.elementAt(index));
                          },
                          itemCount: orderState.categories?.length,
                        ),
                      ],
                    );
                  },
                );
              }),
        );
      }),
    );
  }
}
