import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/all_orders.dto.dart';
import 'package:zeko_hotel_crm/features/order_management/logic/order_history/order_history_cubit.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/constants.dart';

class OrderHistoryListView extends StatefulWidget {
  const OrderHistoryListView({super.key});

  @override
  State<OrderHistoryListView> createState() => _OrderHistoryListViewState();
}

class _OrderHistoryListViewState extends State<OrderHistoryListView> {
  late OrderHistoryCubit _orderHistoryCubit;

  final PagingController<int, OrderPlaced> _pagingController =
      PagingController(firstPageKey: 2);

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
        body: PagedListView<int, OrderPlaced>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<OrderPlaced>(
            newPageErrorIndicatorBuilder: (context) {
              return Text('Error');
            },
            itemBuilder: (context, item, index) => Text('${item.id}'),
          ),
        ),
      ),
    );
  }
}
