import 'package:flutter/foundation.dart';
import 'package:zeko_hotel_crm/core/networking/networking.dart';
import 'package:zeko_hotel_crm/core/networking/response_api.dart';

import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders_dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/order_management_endpoints.dart';

abstract class OrderRepository {
  Future<ApiResponse<PendingOrdersDto>> getPendingOrders();
}

class OrderRepositoryImpl implements OrderRepository {
  late HttpService httpService;

  OrderRepositoryImpl({required this.httpService});

  @override
  Future<ApiResponse<PendingOrdersDto>> getPendingOrders() async {
    try {
      final response =
          await httpService.post(OrderManagementEndpoints.listPendingOrder, {
        "start_time": "2024-08-21T18:30:00.000Z",
        "end_time": "2024-08-29T18:29:59.999Z",
        "hotel_id": 34,
        "hotel": 34
      });

      return response.fold((error) {
        throw error;
      }, (success) {
        debugPrint(success.toString());
        return ApiResponse<PendingOrdersDto>.fromJson(
            success, PendingOrdersDto.fromJson);
      });
    } catch (e) {
      return ApiResponse(data: null, message: 'Error');
    }
  }
}
