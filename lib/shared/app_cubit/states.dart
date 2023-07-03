abstract class GymStates {}

class GymInitialState extends GymStates {}

class GymLoadingState extends GymStates {}

class GymChangeVisiblePasswordEditState extends GymStates {}
class GymChangeVisiblePasswordConfirmEditState extends GymStates {}

class GymChangeBottomNavBarState extends GymStates {}

class GymChangeBottomSheetState extends GymStates {}

class GymChangeHomeLoading extends GymStates {}

class GymChangeProfileState extends GymStates {}

class GymChangeBranchState extends GymStates {}

class GymChangeLanguageState extends GymStates {}

class ProfileImagePickerSuccessState extends GymStates {}

class ProfileImagePickerErrorState extends GymStates {}

class UploadProfileImageLoadingState extends GymStates {}

class UploadProfileImageSuccessState extends GymStates {}

class UploadProfileImageErrorState extends GymStates {}

class UpdateNameLoadingState extends GymStates {}

class UpdateUserBadyLoadingState extends GymStates {}

class UpdateUserPasswordLoadingState extends GymStates {}

class UpdateUserPasswordSuccessState extends GymStates {}

class UpdateUserPasswordErrorState extends GymStates {}

class UserUpdateErrorState extends GymStates {}

class GetUserLoadingState extends GymStates {}

class GetUserSuccessState extends GymStates {}

class GetUserErrorState extends GymStates {
  final String error;
  GetUserErrorState({required this.error});
}

class GetAllUserLoadingState extends GymStates {}

class GetAllUserSuccessState extends GymStates {}

class GetAllUserErrorState extends GymStates {
  final String error;

  GetAllUserErrorState(this.error);
}

class SendMessageSuccessState extends GymStates {}

class SendMessageErrorState extends GymStates {}

class GetMessageSuccessState extends GymStates {}

class ChangeAppModeState extends GymStates {}

class UpdateFatPercentageState extends GymStates {}

class UpdateAgeState extends GymStates {}

class UpdateWeightState extends GymStates {}

class UpdateHeightState extends GymStates {}

class CreateDatabaseState extends GymStates {}

class UpdateDatabaseState extends GymStates {}

class DeleteDatabaseState extends GymStates {}

class InsertDatabaseState extends GymStates {}

class GetDatabaseLoadingState extends GymStates {}

class GetDatabaseState extends GymStates {}

class ChangeBottomSheetState extends GymStates {}

///////////////////////////////
///ToDo: start Bisho

class GetAllMusclesLoading extends GymStates {}
class GetAllMusclesSuccess extends GymStates {}
class GetAllMusclesError extends GymStates {
  final String error;

  GetAllMusclesError({required this.error});
}

class GetPlanLoading extends GymStates {}
class GetPlanSuccess extends GymStates {}
class GetPlanError extends GymStates {
  final String error;

  GetPlanError({required this.error});
}

class GetOnlyMusclesLoading extends GymStates {}
class GetOnlyMusclesSuccess extends GymStates {}
class GetOnlyMusclesError extends GymStates {
  final String error;

  GetOnlyMusclesError({required this.error});
}

class CreateNotesLoadingState extends GymStates {}
class CreateNotesSuccess extends GymStates {}
class CreateNotesError extends GymStates {
}
class GetNotesLoadingState extends GymStates {}
class GetNotesSuccess extends GymStates {}
class GetNotesError extends GymStates {
}
class GetPlanMusclesLoading extends GymStates {}
class GetPlanMusclesSuccess extends GymStates {}
class GetPlanMusclesError extends GymStates {
  final String error;
  GetPlanMusclesError({required this.error});
}


class UpdateRateLoading extends GymStates {}
class UpdateRateSuccess extends GymStates {}
class UpdateRateError extends GymStates {
  final String error;
  UpdateRateError({required this.error});
}


class ChangeValueCheckBox extends GymStates {}
