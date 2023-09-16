abstract class ExercisesStates {}

class ExercisesInitialState extends ExercisesStates {}
class GetAllMusclesLoading extends ExercisesStates {}
class GetAllMusclesSuccess extends ExercisesStates {}
class GetAllMusclesError extends ExercisesStates {
  final String error;

  GetAllMusclesError({required this.error});
}


class GetOnlyMusclesLoading extends ExercisesStates {}
class GetOnlyMusclesSuccess extends ExercisesStates {}
class GetOnlyMusclesError extends ExercisesStates {
  final String error;

  GetOnlyMusclesError({required this.error});
}
