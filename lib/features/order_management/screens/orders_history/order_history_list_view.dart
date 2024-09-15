import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zeko_hotel_crm/core/date_parser.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/all_orders.dto.dart'
    as allOrder;
import 'package:zeko_hotel_crm/features/order_management/logic/order_history/order_history_cubit.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/app_image.dart';
import 'package:zeko_hotel_crm/utils/constants.dart';
import 'package:zeko_hotel_crm/utils/curreny.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class OrderHistoryListView extends StatefulWidget {
  const OrderHistoryListView({super.key});

  @override
  State<OrderHistoryListView> createState() => _OrderHistoryListViewState();
}

class _OrderHistoryListViewState extends State<OrderHistoryListView> {
  late OrderHistoryCubit _orderHistoryCubit;

  final PagingController<int, allOrder.OrderPlaced> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newItems = await _orderHistoryCubit.getAllOrders(pageKey);
      newItems.fold((l) {
        logger.e("Error paginate: $l");
      }, (r) {
        final isLastPage = r.data!.length < PAGE_LIMIT;

        if (isLastPage) {
          _pagingController.appendLastPage(r.data!);
        } else {
          final nextPageKey = pageKey + r.data!.length;
          _pagingController.appendPage(r.data!, nextPageKey.toInt());
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        _orderHistoryCubit = OrderHistoryCubit(orderRepository: getIt.get());
        return _orderHistoryCubit;
      },
      child: Scaffold(
        body: PagedListView<int, allOrder.OrderPlaced>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<allOrder.OrderPlaced>(
              newPageErrorIndicatorBuilder: (context) {
            return Text('Error');
          }, itemBuilder: (context, item, index) {
            return _HistoryCard(item);
          }),
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  allOrder.OrderPlaced item;

  _HistoryCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.roomNumber}',
                style:
                    textStyles.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '#${item.id}',
                style: textStyles.bodySmall,
              ),
            ],
          ),
          Spacing.hxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.orderTime?.toCustom('EEE, MMM dd, yyyy hh:mm a')}',
                style: textStyles.bodySmall,
              ),
            ],
          ),
          Spacing.hxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('+${item.phoneNumber}', style: textStyles.bodySmall),
              Text('Reservation ID: ${item.reservationId}',
                  style: textStyles.bodySmall),
            ],
          ),
          Spacing.hmed,
          const Divider(),
          itemListing(item.items, context),
          const Divider(),
          Row(
            children: [
              Text(
                'Total Bill Amount',
                style: textStyles.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ).expanded(),
              Text(
                '$hotelCurrency${item.billingDetails?.totalDue}',
                style: textStyles.bodyMedium,
              ),
            ],
          ),
          Spacing.hxs,
          if (item.isEscalated == true) ...[
            Chip(
              label: Text(
                'Delayed Order Accepted ${item.acceptedBy}',
                style: textStyles.labelSmall,
              ),
            )
          ],
        ],
      ).padding(Paddings.contentPadding),
    );
  }

  Widget itemListing(List<allOrder.Items>? items, BuildContext context) {
    if (items == null) {
      return const SizedBox();
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (__, _) => const Divider(),
      itemBuilder: (context, index) {
        var item = items.elementAt(index);

        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (item.item?.name != null) ...[
                  Text(
                    '${item.item?.name}',
                    style: textStyles.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                if (item.item?.description != null) ...[
                  Text(
                    '${item.item?.description}',
                    style: textStyles.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                Spacing.hsm,
              ],
            ).expanded(),
            Text('x${item.quantity}'),
            Spacing.wmed,
            ClipRRect(
                borderRadius: Corners.lgBorder,
                child: AppImage(height: 40, width: 40, src: item.item?.image)),
          ],
        ).horizontalGapZero();
      },
    );
  }
}
