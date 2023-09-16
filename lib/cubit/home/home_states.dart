abstract class HomeStates {}

class HomeInitialState extends HomeStates {}
class GymChangeBottomNavBarState extends HomeStates {}

class GetUserLoadingState extends HomeStates {}
class GetUserSuccessState extends HomeStates {}
class GetUserErrorState extends HomeStates {
  final String error;
  GetUserErrorState({required this.error});
}