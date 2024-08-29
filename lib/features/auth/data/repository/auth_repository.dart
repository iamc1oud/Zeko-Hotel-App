import 'package:flutter/foundation.dart';
import 'package:zeko_hotel_crm/core/networking/networking.dart';
import 'package:zeko_hotel_crm/core/networking/response_api.dart';
import 'package:zeko_hotel_crm/features/auth/data/dtos/staff_login_request_dto.dart';
import 'package:zeko_hotel_crm/features/auth/data/dtos/staff_login_response_dto.dart';
import 'package:zeko_hotel_crm/features/auth/data/endpoints.dart';

abstract class AuthRepository {
  Future<ApiResponse<StaffLoginDto>> staffLogin(
      {required String phoneNumber, required String password});
}

class AuthRepositoryImpl implements AuthRepository {
  late HttpService httpService;

  AuthRepositoryImpl({required this.httpService});

  @override
  Future<ApiResponse<StaffLoginDto>> staffLogin(
      {required String phoneNumber, required String password}) async {
    try {
      final response = await httpService.post(
          AuthEndpoints.staffLogin,
          StaffLoginRequestDTO(phoneNumber: phoneNumber, password: password)
              .toJson());

      return response.fold((error) {
        throw error;
      }, (success) {
        return ApiResponse<StaffLoginDto>.fromJson(
            success, StaffLoginDto.fromJson);
      });
    } catch (e) {
      return ApiResponse(data: null, message: 'Error');
    }
  }
}
