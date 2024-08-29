import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeko_hotel_crm/core/storage/storage.dart';
import 'package:zeko_hotel_crm/features/auth/data/repository/auth_repository.dart';
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
    return AuthState(isSignedIn: json['isSignedIn']);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {
      'isSignedIn': state.isSignedIn,
    };
  }

  Future loginStaff() async {
    if (loginFormKey.currentState!.validate()) {
      setLoadingStatus = ButtonState.loading;

      var result = await authRepository.staffLogin(
          // Remove leading + from number
          phoneNumber: phoneNumberController.text.replaceAll('+', ''),
          password: passwordController.text);

      if (result.data!.isPasswordCorrect == false) {
        AlertController.show('Invalid password',
            '${result.data?.isPasswordCorrect.toString()}', TypeAlert.error);
        setLoadingStatus = ButtonState.idle;
      } else {
        var accessToken = result.data!.token!.access!;

        debugPrint('Saved token: $accessToken');

        // Save the token in preferences.
        getIt
            .get<SharedPreferences>()
            .setString(PrefKeys.token.name, accessToken);

        AlertController.show('Logged In', result.message!, TypeAlert.success);

        emit(state.copyWith(isSignedIn: true, loadingState: ButtonState.idle));
      }
    }
  }
}
