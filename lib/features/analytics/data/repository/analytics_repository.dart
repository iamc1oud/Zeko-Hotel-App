import 'package:dartz/dartz.dart';
import 'package:zeko_hotel_crm/core/core.dart';
import 'package:zeko_hotel_crm/core/networking/response_api.dart';
import 'package:zeko_hotel_crm/features/analytics/data/dtos/analytics_dto.dart';
import 'package:zeko_hotel_crm/features/analytics/data/dtos/analytics_response_dto.dart';
import 'package:zeko_hotel_crm/features/analytics/data/endpoints.dart';
import 'package:zeko_hotel_crm/main.dart';

abstract class AnalyticsRepository {
  Future<Either<Exception, ApiResponse<AnalyticsResponseDTO>>>
      getHotelAnalytics(AnalyticsDTO args);
}

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  late HttpService httpService;

  AnalyticsRepositoryImpl({required this.httpService});

  @override
  Future<Either<Exception, ApiResponse<AnalyticsResponseDTO>>>
      getHotelAnalytics(AnalyticsDTO args) async {
    try {
      logger.d('Payload: ${args.toJson()}');
      var result = await httpService.post(AnalyticsEndpoints.hotelAnalytics,
          body: args.toJson());

      return Right(ApiResponse<AnalyticsResponseDTO>.fromJson(
          result, AnalyticsResponseDTO.fromJson));
    } catch (e) {
      return Left(Exception('$e'));
    }
  }
}
