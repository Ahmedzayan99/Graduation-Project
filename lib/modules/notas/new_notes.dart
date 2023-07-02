
// ignore_for_file: file_names
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/note_builder.dart';
class NewNotesScreen extends StatelessWidget {
  const NewNotesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var tasks =GymCubit.get(context).task!;
      return NotasBuilder(
          tasks: tasks
      );
  }
}
