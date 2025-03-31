import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/manage_orders/manage_orders_cubit.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/list_orders/order_item_card.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/widgets.dart';

class OrderManagementTabView extends StatefulWidget {
  const OrderManagementTabView({super.key});

  @override
  State<OrderManagementTabView> createState() => _OrderManagementTabViewState();
}

class _OrderManagementTabViewState extends State<OrderManagementTabView> {
  late Timer _timer;

  late ManageOrdersCubit _manageOrdersCubit;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5),
        (_) => _manageOrdersCubit.getPendingOrders(polling: true));

    FlutterBackgroundService().invoke('start');

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false,
            create: (context) {
              _manageOrdersCubit = ManageOrdersCubit(
                  orderRepository: getIt.get<OrderRepository>());
              return _manageOrdersCubit;
            }),
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
                        if (orderState.isLoading == false) ...[
                          if (orderState.categories?.isEmpty == true) ...[
                            SliverFillRemaining(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppIcon(
                                  AppIcons.orderFood,
                                  size: AppMediaQuery.size.width * 0.7,
                                ),
                                Text(
                                  'No more pending orders',
                                  style: textStyles.bodySmall?.copyWith(
                                      fontFamily:
                                          GoogleFonts.openSans().fontFamily),
                                )
                              ],
                            ))
                          ],
                        ],
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return OrderItemCard(
                                  order:
                                      orderState.categories!.elementAt(index));
                            },
                            childCount: orderState.categories?.length,
                          ),
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
