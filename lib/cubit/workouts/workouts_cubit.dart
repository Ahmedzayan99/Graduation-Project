
import 'package:blackgym/cubit/workouts/workouts_states.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/models/plan/plan.dart';
import '../../data/network/constants.dart';
import '../../data/network/local/cache_helper.dart';
import '../../data/network/remote/dio_helper.dart';
import '../../screens/exercises/exercises.dart';
import '../../screens/home/home.dart';

class WorkoutsCubit extends Cubit<WorkoutsStates> {
  WorkoutsCubit() : super(WorkoutsInitialState());

  get index => null;

  static WorkoutsCubit get(context) => BlocProvider.of(context);
  PlanModel? planlModel;
  Future<void> getPlan(
      {required String? day,}
      ) async {
    emit(GetPlanLoading());
    await DioHelper.getData(url:'$api${CacheHelper.getDataIntoShPre(key:'token')}/$day')
        .then((value) {
      planlModel = PlanModel.fromJson(value.data);
      print('dddddddddddddddd');
      emit(GetPlanSuccess());
      //  }
    }).catchError((error) {
      emit(GetPlanError(error: error.toString()));
      print('ssssssssssssssssssssssss' + error.toString());
    });
  }


  var todayDateBeforeFormat = DateTime.now();
  var dateBarStartDay = DateTime.now();
  DatePickerController? today;
  String? date = DateFormat('EEEE,dd MMMM').format((DateTime.now()));

}