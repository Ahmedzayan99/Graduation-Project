abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class GymChangeVisiblePasswordLoginState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState(this.error);
}