
// ignore_for_file: file_names
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/widgets/note_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DoneTask extends StatelessWidget {
  const DoneTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener:(context, state) {

      } ,
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text('Dane',),
                Icon(Icons.task,color: ColorsManager.primary),
              ],
            ),
          ),
            body:GymCubit.get(context).taskdane!.isNotEmpty?NotasBuilder(
              tasks:GymCubit.get(context).taskdane!,
            ):Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hourglass_empty_outlined,
                      size: 60.0,
                      color: ColorsManager.primary),
                  Text('There are no tasks. Add a new task',
                    style: TextStyle(
                      color: ColorsManager.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),)
                ],
              ),
            ),
        );
      },
    );
  }
}
