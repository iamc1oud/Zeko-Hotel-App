import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/cubit/manage_orders_cubit.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/list_orders/order_item_card.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/widgets.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class PendingOrdersListView extends StatefulWidget {
  const PendingOrdersListView({super.key});

  @override
  State<PendingOrdersListView> createState() => _PendingOrdersListViewState();
}

class _PendingOrdersListViewState extends State<PendingOrdersListView> {
  @override
  void initState() {
    // Get orders
    context.read<ManageOrdersCubit>().getPendingOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageOrdersCubit, ManageOrdersState>(
      builder: (context, orderState) {
        return Column(
          children: [
            Row(
              children: [
                const Icon(Icons.fastfood_outlined),
                Spacing.wsm,
                Text(
                  'Orders',
                  style: textStyles.headlineSmall,
                )
              ],
            ).padding(Paddings.contentPadding),
            if (orderState.isLoading == true) ...[const Loading()],
            if (orderState.isLoading == false) ...[
              ListView.builder(
                padding: Paddings.horizontalPadding,
                itemCount: orderState.categories?.length ?? 1,
                itemBuilder: (context, index) {
                  return OrderItemCard(
                      order: orderState.categories!.elementAt(index));
                },
              ).expanded(),
            ],
          ],
        );
      },
    );
  }
}
