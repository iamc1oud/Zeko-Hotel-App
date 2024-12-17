import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeko_hotel_crm/core/navigation/app_navigation.dart';
import 'package:zeko_hotel_crm/core/storage/storage.dart';
import 'package:zeko_hotel_crm/features/auth/data/dtos/hotel_details_response_dto.dart';
import 'package:zeko_hotel_crm/features/auth/data/repository/auth_repository.dart';
import 'package:zeko_hotel_crm/features/auth/screens/login_view.dart';
import 'package:zeko_hotel_crm/features/home_screen/screens/bottom_navigation_bar.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/widgets.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  late AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthState()) {
    // Load last emitted states
    hydrate();
  }

  // Form Controllers
  final loginFormKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  set setLoginStatus(bool v) {
    emit(state.copyWith(isSignedIn: v));
  }

  set setLoadingStatus(ButtonState v) {
    emit(state.copyWith(loadingState: v));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState(
      isSignedIn: json['isSignedIn'],
      isSuperuser: json['isSuperuser'],
      // hotelDetails: json['hotelDetails']
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {
      'isSignedIn': state.isSignedIn,
      'isSuperuser': state.isSuperuser,
      // 'hotelDetails': state.hotelDetails?.toJson()
    };
  }

  Future loginStaff() async {
    if (loginFormKey.currentState!.validate()) {
      setLoadingStatus = ButtonState.loading;

      var result = await authRepository.staffLogin(
          // Remove leading + from number
          phoneNumber: phoneNumberController.text.replaceAll('+', ''),
          password: passwordController.text);

      logger.d(result);

      if (result.data!.isPasswordCorrect == false) {
        AlertController.show('Invalid password', '', TypeAlert.error);
        setLoadingStatus = ButtonState.idle;
      } else {
        var accessToken = result.data!.token!.access!;

        // Save the token in preferences.
        await getIt
            .get<SharedPreferences>()
            .setString(PrefKeys.token.name, accessToken);

        // Get token
        var token = await FirebaseMessaging.instance.getToken();

        if (token != null) {
          logger.d("FCM Token: $token");
          var deviceId = await getDeviceId();
          await authRepository.updateFCMToken(token: token, deviceId: deviceId);
        }

        emit(state.copyWith(
          isSignedIn: true,
          loadingState: ButtonState.idle,
          isSuperuser: result.data?.isSuperuser,
        ));

        AppNavigator.slideReplacement(const HomeScreen());
      }
    }
  }

  Future getHotelDetails() async {
    var result = await authRepository.hotelDetails();

    var token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      logger.d("Updated FCM Token: $token");
      var deviceId = await getDeviceId();
      var response =
          await authRepository.updateFCMToken(token: token, deviceId: deviceId);
      logger.d(response);
    }

    // Save currency in prefs.
    getIt
        .get<SharedPreferences>()
        .setString(PrefKeys.curreny.name, result.detail!.currency!);

    emit(state.copyWith(hotelDetails: result));
  }

  Future<String> getDeviceId() async {
    late final AndroidDeviceInfo androidDevice;
    late final IosDeviceInfo iosDevice;

    // Get device info.
    final deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    if (Platform.isAndroid) {
      androidDevice = await deviceInfo.androidInfo;
      deviceId = androidDevice.id;
    } else if (Platform.isIOS) {
      iosDevice = await deviceInfo.iosInfo;
      deviceId = iosDevice.identifierForVendor;
    }

    logger.i("Unique device ID: $deviceId");
    return deviceId ?? '';
  }

  void logout() {
    try {
      phoneNumberController.clear();
      passwordController.clear();
      emit(state.copyWith(isSignedIn: false, isSuperuser: false));
      AppNavigator.slideReplacement(const LoginView());
    } catch (e) {
      logger.e('Error popping: $e');
    }
    clear();
  }
}
