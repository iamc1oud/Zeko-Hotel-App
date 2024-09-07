part of 'auth_cubit.dart';

class AuthState {
  bool? isSignedIn;
  bool? isSuperuser;
  ButtonState? loadingState;

  AuthState(
      {this.isSignedIn = false,
      this.loadingState = ButtonState.idle,
      this.isSuperuser = false});

  AuthState copyWith(
      {bool? isSignedIn, ButtonState? loadingState, bool? isSuperuser}) {
    return AuthState(
        isSuperuser: isSuperuser ?? this.isSuperuser,
        isSignedIn: isSignedIn ?? this.isSignedIn,
        loadingState: loadingState ?? this.loadingState);
  }
}
