part of 'auth_cubit.dart';

class AuthState {
  bool? isSignedIn;
  ButtonState? loadingState;

  AuthState({
    this.isSignedIn = false,
    this.loadingState = ButtonState.idle,
  });

  AuthState copyWith({bool? isSignedIn, ButtonState? loadingState}) {
    return AuthState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
        loadingState: loadingState ?? this.loadingState);
  }
}
