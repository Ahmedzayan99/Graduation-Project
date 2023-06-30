import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/widgets/home_training_item_widget.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener: (context, state) {
        if (GymCubit.get(context).musclesModel!.data!.isEmpty){
          showProgressIndicator(context);
        }
        if (GymCubit.get(context).internet==false) {
          return showErrorMassage(context);
        }
      },
      builder: (context, state){
        var cubit = GymCubit.get(context);
       if(cubit.internet! && GymCubit.get(context).musclesModel!.data!.isNotEmpty)
        {
         return const HomeTrainingItemWidget();
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