import 'package:dartz/dartz.dart';
import 'package:zeko_hotel_crm/core/networking/networking.dart';
import 'package:zeko_hotel_crm/core/networking/response_api.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/orders.dto.dart';

import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders_dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/order_management_endpoints.dart';
import 'package:zeko_hotel_crm/main.dart';

abstract class OrderRepository {
  Future<Either<Exception, ApiResponse<PendingOrdersDTO>>> getPendingOrders();
  Future<Either<Exception, ApiResponse<SuccessAcceptOrderDTO>>> acceptOrder(
      AcceptOrderDTO args);

  Future<Either<Exception, ListingApiResponse>> partialAcceptOrder(
      AcceptOrderDTO args);

  Future<Either<Exception, ApiResponse<SuccessAcceptOrderDTO>>> rejectOrder(
      RejectOrderDTO args);
}

class OrderRepositoryImpl implements OrderRepository {
  late HttpService httpService;

  OrderRepositoryImpl({required this.httpService});

  @override
  Future<Either<Exception, ApiResponse<PendingOrdersDTO>>>
      getPendingOrders() async {
    try {
      final response =
          await httpService.post(OrderManagementEndpoints.listPendingOrder);

      var decoded = ApiResponse<PendingOrdersDTO>.fromJson(
          response, PendingOrdersDTO.fromJson);

      return Right(decoded);
    } catch (e) {
      logger.d("getPendingOrders: $e");
      return Left(Exception('$e'));
    }
  }

  @override
  Future<Either<Exception, ApiResponse<SuccessAcceptOrderDTO>>> acceptOrder(
      AcceptOrderDTO args) async {
    try {
      final response = await httpService
          .post(OrderManagementEndpoints.acceptOrder, body: args.toJson());

      var decoded = ApiResponse<SuccessAcceptOrderDTO>.fromJson(
          response, SuccessAcceptOrderDTO.fromJson);

      return Right(decoded);
    } catch (e) {
      return Right(ApiResponse(data: null, message: 'Error'));
    }
  }

  @override
  Future<Either<Exception, ListingApiResponse>> partialAcceptOrder(
      AcceptOrderDTO args) async {
    try {
      final response = await httpService.post(
          OrderManagementEndpoints.partialAcceptOrder,
          body: args.toJson());

      var decoded =
          ListingApiResponse.fromJson(response, SuccessAcceptOrderDTO.fromJson);

      return Right(decoded);
    } catch (e) {
      return Right(ListingApiResponse(data: null, message: '$e'));
    }
  }

  @override
  Future<Either<Exception, ApiResponse<SuccessAcceptOrderDTO>>> rejectOrder(
      RejectOrderDTO args) async {
    try {
      final response = await httpService
          .post(OrderManagementEndpoints.rejectOrder, body: args.toJson());

      var decoded = ApiResponse<SuccessAcceptOrderDTO>.fromJson(
          response, SuccessAcceptOrderDTO.fromJson);

      return Right(decoded);
    } catch (e) {
      return Right(ApiResponse(data: null, message: 'Error'));
    }
  }
}
