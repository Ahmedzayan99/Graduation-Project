
// ignore_for_file: file_names
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/widgets/note_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DoneTask extends StatelessWidget {
  const DoneTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener:(context, state) {} ,
      builder: (context, state)
      {
        var tasks =GymCubit.get(context).doneTasks;
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text('DaneTasks',),
                Icon(Icons.task,color: ColorsManager.primary),
              ],
            ),
          ),
          body:NotasBuilder(
              tasks:tasks
          ),
        );
      },
    );
  }
}
