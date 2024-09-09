import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/core/date_parser.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders_dto.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/manage_orders/manage_orders_cubit.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/order/order_cubit.dart';

import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/widgets.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';
import 'package:zeko_hotel_crm/utils/utils.dart';

class OrderItemCard extends StatefulWidget {
  final OrderCategory order;

  OrderItemCard({super.key, required this.order});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  late OrderCubit _orderCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        _orderCubit = OrderCubit(
            orderRepository: getIt.get(),
            manageOrdersCubit: context.read<ManageOrdersCubit>())
          ..setOrder = widget.order;

        return _orderCubit;
      },
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return Card(
            shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
            color: Colors.yellow.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                basicDetail(widget.order.id, widget.order.timeStamp,
                    widget.order.isEscalated),
                const Divider(),
                BlocSelector<OrderCubit, OrderState, List<Order$Items>?>(
                  selector: (state) {
                    return state.items;
                  },
                  builder: (context, itemsState) {
                    return itemListing(itemsState, context);
                  },
                ),
                const Divider(),
                guestDetail(widget.order.category, widget.order.roomNumber),
                const Divider(),
                orderConfirmation(widget.order.items),
              ],
            ).padding(Paddings.contentPadding),
          );
        },
      ).padding(Paddings.contentPadding),
    );
  }

  Widget basicDetail(int id, String timeStamp, bool isEscalated) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #$id',
              style:
                  textStyles.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacing.hxs,
            Text(
              timeStamp.toCustom('EEE, MMM dd, yyyy hh:mm a'),
              style: textStyles.bodySmall,
            ),
          ],
        ).expanded(),
        if (isEscalated == true) ...[
          Center(
              child: const Icon(
            Icons.notification_important_outlined,
            color: Colors.red,
          )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .fade(duration: 1.5.seconds))
        ],
      ],
    );
  }

  Widget itemListing(List<Order$Items>? items, BuildContext context) {
    if (items == null) {
      return const SizedBox();
    }

    return Column(
      children: items.map((item) {
        return CheckboxListTile.adaptive(
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.purple,
          checkboxShape:
              const RoundedRectangleBorder(borderRadius: Corners.medBorder),
          value: item.isSelected,
          onChanged: (v) {
            HapticFeedback.lightImpact();

            context.read<OrderCubit>().toggleItemCheck(v!, item);
          },
          contentPadding: EdgeInsets.zero,
          title: Text(
            '${item.item.item.name}',
            style: textStyles.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          dense: true,
          subtitle: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (item.item.item.description != null) ...[
                    Text(
                      '${item.item.item.description}',
                      style: textStyles.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                  Spacing.hsm,
                  Row(
                    children: [
                      // If discount price is available, then strike the original price.
                      if (item.item.item.discPrice != null) ...[
                        RichText(
                          text: TextSpan(
                              text:
                                  '$hotelCurrency${item.item.item.discPrice.toString().removeZero()} ',
                              style: textStyles.bodyMedium,
                              children: [
                                TextSpan(
                                    text:
                                        '$hotelCurrency${item.item.item.price.toString().removeZero()}',
                                    style: textStyles.bodySmall?.copyWith(
                                        decoration: TextDecoration.lineThrough))
                              ]),
                        ).expanded(),
                      ],
                      // If discount price is not available, then show the original price.
                      if (item.item.item.discPrice == null) ...[
                        Text(
                          '$hotelCurrency${item.item.item.price.toString().removeZero()}',
                          style: textStyles.bodyMedium,
                        ).expanded(),
                      ],

                      Text(
                        'Qty: ${item.quantity}',
                        style: textStyles.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ).expanded(),
              Spacing.wmed,
              ClipRRect(
                  borderRadius: Corners.lgBorder,
                  child: AppImage(
                      height: 40, width: 40, src: item.item.item.image)),
            ],
          ),
        ).horizontalGapZero();
      }).toList(),
    );
  }

  Widget guestDetail(String category, String roomNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
            text: TextSpan(
                style: textStyles.labelLarge,
                text: 'Menu ',
                children: [
              TextSpan(
                text: category,
                style: textStyles.labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ])),
        RichText(
            text: TextSpan(
                style: textStyles.labelLarge,
                text: 'Room ',
                children: [
              TextSpan(
                text: roomNumber,
                style: textStyles.labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ])),
      ],
    );
  }

  Widget orderConfirmation(List<OrderItem> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilledButton.icon(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: Corners.lgBorder,
                    side: BorderSide(color: Colors.green.shade400))),
                backgroundColor: WidgetStatePropertyAll(
                    Colors.green.shade100.withOpacity(0.3))),
            onPressed: () {
              _orderCubit.acceptOrder();
            },
            label: Text(
              'Accept',
              style: textStyles.bodyMedium,
            ),
            icon: const Icon(
              CupertinoIcons.checkmark_alt,
              color: Colors.green,
            )).expanded(),
        Spacing.wmed,
        FilledButton.icon(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: Corners.lgBorder,
                    side: BorderSide(color: Colors.red.shade400))),
                backgroundColor: WidgetStatePropertyAll(
                    Colors.red.shade100.withOpacity(0.3))),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    TextEditingController rejectController =
                        TextEditingController();

                    final formKey = GlobalKey<FormState>();

                    return BlocProvider.value(
                      value: _orderCubit,
                      child: BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          return AlertDialog.adaptive(
                            title: const Text('Reject Order'),
                            content: Material(
                              color: Colors.transparent,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Spacing.hlg,
                                    TextFormField(
                                      maxLines: 3,
                                      controller: rejectController,
                                      autofocus: true,
                                      validator: (v) {
                                        if (v!.isEmpty == true) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Reason',
                                      ),
                                    ),
                                    Wrap(
                                      runSpacing: 10,
                                      spacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: ['Out of stock', 'Unavailable']
                                          .map((v) {
                                        return GestureDetector(
                                          onTap: () {
                                            rejectController.text = v;
                                          },
                                          child: Chip(
                                            label: Text(
                                              v,
                                              style: textStyles.bodySmall,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    _orderCubit
                                        .rejectOrder(rejectController.text)
                                        .then((v) {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: const Text(
                                  'Reject',
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  });
            },
            label: Text(
              'Reject',
              style: textStyles.bodyMedium,
            ),
            icon: Icon(
              CupertinoIcons.xmark,
              color: Colors.red.shade400,
            )).expanded(),
      ],
    );
  }
}
