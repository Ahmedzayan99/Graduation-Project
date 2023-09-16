abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}
class GymChangeBranchState extends SettingsStates {}
class GymChangeEvaluateCoachState extends SettingsStates {}
class GymChangeProfileState extends SettingsStates {}
class UpdateRateLoading extends SettingsStates {}
class UpdateRateSuccess extends SettingsStates {}
class UpdateRateError extends SettingsStates {
  final String error;
  UpdateRateError({required this.error});
}
class GetUserLoadingState extends SettingsStates {}
class GetUserSuccessState extends SettingsStates {}
class GetUserErrorState extends SettingsStates {
  final String error;
  GetUserErrorState({required this.error});
}
class ChangeLanguageState extends SettingsStates {}
class ChangeAppModeState extends SettingsStates {}
class ChangeBottomSelectLanguage extends SettingsStates {}


class GymChangeVisiblePasswordEditState extends SettingsStates {}
class GymChangeVisiblePasswordConfirmEditState extends SettingsStates {}


class ProfileImagePickerSuccessState extends SettingsStates {}

class ProfileImagePickerErrorState extends SettingsStates {}

class UploadProfileImageLoadingState extends SettingsStates {}

class UploadProfileImageSuccessState extends SettingsStates {}

class UploadProfileImageErrorState extends SettingsStates {}

class UpdateNameLoadingState extends SettingsStates {}


class UpdateUserPasswordLoadingState extends SettingsStates {}

class UpdateUserPasswordSuccessState extends SettingsStates {}

class UpdateUserPasswordErrorState extends SettingsStates {}

class UserUpdateErrorState extends SettingsStates {}

