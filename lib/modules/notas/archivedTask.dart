
// ignore_for_file: file_names
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/note_builder.dart';
class ArchivedTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener:(context, state) {} ,
      builder: (context, state)
      {
        var tasks =GymCubit.get(context).archiveTasks;

        return Scaffold(appBar: AppBar(),
          body: notesbuilder(
              tasks:tasks
          ),
        );
      },
    );
  }
}
