
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/models/exercises/all_exercises.dart';
import '../../data/models/exercises/only_muscle.dart';
import '../../data/models/muscles/muscles.dart';
import '../../data/network/constants.dart';
import '../../data/network/remote/dio_helper.dart';
import 'exercises_states.dart';

class ExercisesCubit extends Cubit<ExercisesStates> {
  ExercisesCubit() : super(ExercisesInitialState());

  get index => null;

  static ExercisesCubit get(context) => BlocProvider.of(context);


  ExercisesModel? onlyMucsleModel=ExercisesModel();
  Future<void> getOnlyMuscles() async {
    emit(GetOnlyMusclesLoading());
    await DioHelper.getData(url:allExercises)
        .then((value) {
      onlyMucsleModel = ExercisesModel.fromJson(value.data);
      emit(GetOnlyMusclesSuccess());
    })
        .catchError((error) {
      emit(GetOnlyMusclesError(error: error.toString()));
    });
  }

  MusclesModel? musclesModel=MusclesModel();
  Future<void> getAllMuscles() async {
    emit(GetAllMusclesLoading());
    await DioHelper.getData(url: muscles)
        .then((value) {
      musclesModel = MusclesModel.fromJson(value.data);
      emit(GetAllMusclesSuccess());
    })
        .catchError((error) {
      emit(GetAllMusclesError(error: error.toString()));
    });
  }



  OnlyMucsleModel? onlyMucsleModel1=OnlyMucsleModel();
  Future<void> getOnlyMuscles1({
    required int? id,

  } ) async {
    emit(GetOnlyMusclesLoading());
    onlyMucsleModel1==[];
    await DioHelper.getData(url:'${muscleMuscles}$id')
        .then((value) {
      onlyMucsleModel1 = OnlyMucsleModel.fromJson(value.data);
      emit(GetOnlyMusclesSuccess());
    })
        .catchError((error) {
      emit(GetOnlyMusclesError(error: error.toString()));
    });
  }


}