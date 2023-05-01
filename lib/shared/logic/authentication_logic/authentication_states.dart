
abstract class AuthStates{
}

class GymChangeVisiblePasswordLoginState extends AuthStates{
}
class GymChangeVisiblePasswordRegisterState extends AuthStates{
}


class GymChangeGenderState extends AuthStates{
}
class GymChangeFatPercentageState extends AuthStates{
}
class GymChangeAgeState extends AuthStates{
}
class GymChangeWeightState extends AuthStates{
}
class GymChangeHeightState extends AuthStates{
}



class  AuthInitialState extends AuthStates{
}
class PhoneLoadingState extends AuthStates{}

class PhoneErrorState extends AuthStates{
  final String? error;

  PhoneErrorState({required this.error});
}

class PhoneNumberSubmitted extends AuthStates{}

class PhoneOTPVerified extends AuthStates{}



class RegisterLoadingState extends AuthStates{
}
class RegisterSuccessState extends AuthStates{
}
class RegisterErrorState extends AuthStates{
  final String error;
    RegisterErrorState(this.error);
}

class CreateUserLoadingState extends AuthStates{
}
class CreateUserSuccessState extends AuthStates{
}
class CreateUserErrorState extends AuthStates{
  final String error;
  CreateUserErrorState(this.error);
}


class LoginLoadingState extends AuthStates{
}
class LoginSuccessState extends AuthStates{
 // final String uId;
 // LoginSuccessState(this.uId);
}
class LoginErrorState extends AuthStates{
  final String error;
  LoginErrorState(this.error);
}

class SignOutSuccessState extends AuthStates{
}