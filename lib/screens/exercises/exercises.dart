
import 'package:blackgym/screens/exercises/widgets/home_training_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/exercises/exercises_cubit.dart';
import '../../cubit/exercises/exercises_states.dart';
import '../../shared/components/components.dart';
class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExercisesCubit,ExercisesStates>(
      listener: (context, state) {
        if (ExercisesCubit.get(context).musclesModel!.data!.isEmpty){
          showProgressIndicator(context);
        }
      },
      builder: (context, state){
        var cubit = ExercisesCubit.get(context);
       if(ExercisesCubit.get(context).musclesModel!.data! !=null)
        {
         return const HomeTrainingItemWidget();
       }
       else if(state is GetAllMusclesLoading ){
         return Center(child: defaultProgressIndicator(),);
       }
       else {
         return Scaffold(
           appBar: AppBar(),
           body:Text('',style: TextStyle(color: Colors.pink)),
         );
            }
      }
    );
  }
}
/*
*/