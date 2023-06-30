
// ignore_for_file: file_names
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/note_builder.dart';
class ArchivedTask extends StatelessWidget {
  const ArchivedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener:(context, state) {

      } ,
      builder: (context, state)
      {
        var tasks =GymCubit.get(context).task!;
        if (state is gNotesLoadingState){
          return defaultProgressIndicator();
        }
        if(tasks != null) {
          return NotasBuilder(
              tasks: tasks
          );
        }
        else return Center(
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
        );
        },
    );
  }
}
