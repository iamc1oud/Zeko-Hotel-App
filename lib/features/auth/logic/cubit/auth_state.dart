part of 'auth_cubit.dart';

class AuthState {
  bool? isSignedIn;
  bool? isSuperuser;
  ButtonState? loadingState;
  HotelDetailsDTO? hotelDetails;

  AuthState(
      {this.isSignedIn = false,
      this.loadingState = ButtonState.idle,
      this.isSuperuser = false,
      this.hotelDetails});

  AuthState copyWith(
      {bool? isSignedIn,
      ButtonState? loadingState,
      bool? isSuperuser,
      HotelDetailsDTO? hotelDetails}) {
    return AuthState(
        hotelDetails: hotelDetails ?? this.hotelDetails,
        isSuperuser: isSuperuser ?? this.isSuperuser,
        isSignedIn: isSignedIn ?? this.isSignedIn,
        loadingState: loadingState ?? this.loadingState);
  }
}
