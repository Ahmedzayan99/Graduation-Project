
import 'package:blackgym/screens/notas/widgets/note_builder.dart';
import 'package:flutter/material.dart';

import '../../cubit/notas/notes_cubit.dart';

class NewNotesScreen extends StatelessWidget {
  const NewNotesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var tasks =NotesCubit.get(context).task!;
      return NotasBuilder(
          tasks: tasks
      );
  }
}
