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
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GymCubit.get(context);
       if(cubit.internet!) {
         return ConditionalBuilder(
          condition:cubit.musclesModel!.data!.isNotEmpty,
          builder:(context) =>  const HomeTrainingItemWidget(),
          fallback: (context) => showProgressIndicator(),
        );
       }
       else {
             return Center(
               child: Icon(
                 Icons.signal_wifi_connected_no_internet_4,
                 color: Colors.amber,
                 size: 200.0,),
             );
            }
      }
    );
  }
}
/*
*/