
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


class ProfileImagePickerSuccessState extends GymStates{
}
class ProfileImagePickerErrorState extends GymStates{
}

class UploadProfileImageSuccessState extends GymStates{
}
class UploadProfileImageErrorState extends GymStates{
}

class UserUpdateErrorState extends GymStates{
}



class GetUserLoadingState extends GymStates{
}
class GetUserSuccessState extends GymStates{
}
class GetUserErrorState extends GymStates
{
  final String error;
  GetUserErrorState(this.error);
}

class GetAllUserLoadingState extends GymStates{
}
class GetAllUserSuccessState extends GymStates{
}
class GetAllUserErrorState extends GymStates
{
  final String error;
  GetAllUserErrorState(this.error);
}


class SendMessageSuccessState extends GymStates{
}
class SendMessageErrorState extends GymStates{
}
class GetMessageSuccessState extends GymStates {
}





///////////////////////////////


