abstract class WorkoutsStates {}

class WorkoutsInitialState extends WorkoutsStates {}
class GetPlanLoading extends WorkoutsStates {}
class GetPlanSuccess extends WorkoutsStates {}
class GetPlanError extends WorkoutsStates {
  final String error;

  GetPlanError({required this.error});
}
