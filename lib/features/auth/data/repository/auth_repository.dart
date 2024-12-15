import 'package:zeko_hotel_crm/core/networking/networking.dart';
import 'package:zeko_hotel_crm/core/networking/response_api.dart';
import 'package:zeko_hotel_crm/features/auth/data/dtos/hotel_details_response_dto.dart';
import 'package:zeko_hotel_crm/features/auth/data/dtos/staff_login_request_dto.dart';
import 'package:zeko_hotel_crm/features/auth/data/dtos/staff_login_response_dto.dart';
import 'package:zeko_hotel_crm/features/auth/data/endpoints.dart';
import 'package:zeko_hotel_crm/main.dart';

abstract class AuthRepository {
  Future<ApiResponse<StaffLoginDto>> staffLogin(
      {required String phoneNumber, required String password});

  Future<ApiResponse> updateFCMToken({required String token});

  Future<HotelDetailsDTO> hotelDetails();
}

class AuthRepositoryImpl implements AuthRepository {
  late HttpService httpService;

  AuthRepositoryImpl({required this.httpService});

  @override
  Future<ApiResponse<StaffLoginDto>> staffLogin(
      {required String phoneNumber, required String password}) async {
    try {
      final response = await httpService.post(AuthEndpoints.staffLogin,
          body:
              StaffLoginRequestDTO(phoneNumber: phoneNumber, password: password)
                  .toJson());

      return ApiResponse<StaffLoginDto>.fromJson(
          response, StaffLoginDto.fromJson);
    } catch (e) {
      return ApiResponse(data: null, message: 'Error');
    }
  }

  @override
  Future<HotelDetailsDTO> hotelDetails() async {
    try {
      final response = await httpService.post(
        AuthEndpoints.aboutHotel,
      );

      return HotelDetailsDTO.fromJson(response);
    } catch (e) {
      return HotelDetailsDTO(detail: null);
    }
  }

  @override
  Future<ApiResponse> updateFCMToken({required String token}) async {
    try {
      final response = await httpService.post(
        AuthEndpoints.fcm,
        body: {"token": token},
      );

      logger.d(response);

      return ApiResponse.fromJson(response, null);
    } catch (e) {
      return ApiResponse();
    }
  }
}
