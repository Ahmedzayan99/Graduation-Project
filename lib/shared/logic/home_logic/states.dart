
abstract class GymStates{
}
class GymInitialState extends GymStates{
}
class GymLoadingState extends GymStates{
}
class GymChangeBottomNavBarState extends GymStates{
}
class GymChangeBottomSheetState extends GymStates{
}

class GymChangeHomeLoading extends GymStates{
}
class GymChangeProfileState extends GymStates{
}
class GymChangeLanguageState extends GymStates{
}
class GymChangeVisiblePasswordLoginState extends GymStates{
}
class GymChangeVisiblePassworRegisterdState extends GymStates{
}

class GymRegisterLoadingState extends GymStates{
}
class GymRegisterSuccessState extends GymStates{
}
class GymRegisterErrorState extends GymStates{
  final String error;
  GymRegisterErrorState(this.error);
}
class GymLoginLoadingState extends GymStates{
}
class GymLoginSuccessState extends GymStates{
  final String uId;
  GymLoginSuccessState(this.uId);
}
class GymLoginErrorState extends GymStates{
  final String error;
  GymLoginErrorState(this.error);
}
class GymCreateUserSuccessState extends GymStates{
  final String uId;
  GymCreateUserSuccessState(this.uId);
}
class GymCreateUserErrorState extends GymStates{
  final String error;
  GymCreateUserErrorState(this.error);
}



class GymGetUserLoadingState extends GymStates{
}
class GymGetUserSuccessState extends GymStates{
}
class GymGetUserErrorState extends GymStates{
  final String error;
  GymGetUserErrorState(this.error);
}

class GymProfileImagePickerSuccessState extends GymStates{
}
class GymProfileImagePickerErrorState extends GymStates{
}

class GymUploadProfileImageSuccessState extends GymStates{
}
class GymUploadProfileImageErrorState extends GymStates{
}

class GymUserUpdateErrorState extends GymStates{
}

class GymSignOutSuccessState extends GymStates{
}

class GymSignOutErrorState extends GymStates{
}
///////////////////////////////


class PhoneAuthInitial extends GymStates {}

class PhoneLoadingState extends GymStates{}

class PhoneErrorState extends GymStates{
  final String? error;

  PhoneErrorState({required this.error});
}

class PhoneNumberSubmitted extends GymStates{}

class PhoneOTPVerified extends GymStates{}