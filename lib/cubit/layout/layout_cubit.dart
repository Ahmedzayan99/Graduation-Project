
import 'package:blackgym/screens/notas/notes_layout.dart';
import 'package:blackgym/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../screens/exercises/exercises.dart';
import '../../screens/home/home.dart';
import '../../screens/workouts/workouts.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(GymInitialState());

  get index => null;

  static LayoutCubit get(context) => BlocProvider.of(context);

  //<<<<<<<<<<<<<<<<<Start the cubit of BottomNavigationBar >>>>>>>>>>>>>>>>>>>>>>
  int current = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const ExercisesScreen(),
    WorkoutsScreen(),
    NotesLayoutScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    current = index;
    emit(GymChangeBottomNavBarState());
  }
}