
// ignore_for_file: file_names
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:blackgym/shared/widgets/note_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DoneTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener:(context, state) {} ,
      builder: (context, state)
      {
        var tasks =GymCubit.get(context).doneTasks;
        return notesbuilder(
            tasks:tasks
        );
      },
    );
  }
}
