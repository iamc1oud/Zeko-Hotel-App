import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/core/date_parser.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders_dto.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class OrderItemCard extends StatelessWidget {
  final OrderCategory order;

  const OrderItemCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var orderTime = order.timeStamp.toString().to12Hr();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacing.hlg,
          Row(
            children: [
              Text(
                order.roomNumber,
                style: textStyles.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ).expanded(),
              Text(
                '#${order.id}',
                style: textStyles.bodySmall,
              ),
            ],
          ).padding(Paddings.horizontalPadding),
          GridView(
            shrinkWrap: true,
            padding: Paddings.contentPadding,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 4),
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.grey),
                  Spacing.wsm,
                  Text(
                    '${order.timeStamp.toString().toCustom('dd MMM')} at $orderTime',
                    style: textStyles.bodySmall,
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.menu, color: Colors.grey),
                  Spacing.wsm,
                  Text(
                    order.category,
                    style: textStyles.bodySmall,
                  )
                ],
              )
            ],
          ),
          // List order items
          ListView.builder(
            shrinkWrap: true,
            itemCount: order.items.length,
            itemBuilder: (context, index) {
              var item = order.items.elementAt(index);
              return item.item.image != null
                  ? SizedBox.square(
                      dimension: 35, child: Image.network(item.item.image!))
                  : Text('${item.id}');
            },
          ),

          orderActions().padding(Paddings.horizontalPadding),
          Spacing.hmed,
        ],
      ),
    );
  }

  Row orderActions() {
    return Row(
      children: [
        FilledButton(
          onPressed: () {},
          style: const ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.green)),
          child: Text(
            'Accept',
            style: textStyles.bodySmall?.copyWith(color: Colors.white),
          ),
        ).expanded(),
        Spacing.wlg,
        FilledButton(
          onPressed: () {},
          style: const ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.red)),
          child: Text(
            'Reject',
            style: textStyles.bodySmall?.copyWith(color: Colors.white),
          ),
        ).expanded(),
      ],
    );
  }
}
