

import 'package:blackgym/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/chats.dart';
import '../../modules/exercises.dart';
import '../../modules/gym.dart';
import '../../modules/home.dart';
import '../../modules/settings.dart';
import '../../modules/workouts.dart';

class GymCubit extends Cubit<GymStates> {
  GymCubit() : super(GymInitialState());

  static GymCubit get(context) => BlocProvider.of(context);
  bool isBottomSheet = false;
  int current = 0;
  List< BottomNavigationBarItem> bottomitem  = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_filled,
      ),
      label: 'Home',),
    BottomNavigationBarItem(
      icon:Icon(Icons.accessibility_new),
      label: 'exercises',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.work_outline_sharp),
      label: 'Workouts',

    ),
    BottomNavigationBarItem(

      icon: Icon(
        Icons.chat_bubble_outline_rounded,
      ),
      label: 'Chat',),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'settings',),
];
  List<Widget> screen = [
    HomeScreen(),
    ExercisesScreen(),
    WorkoutsScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];
  void changeIndex(int index) {
    current = index;
    emit(GymChangeBottomNavBarState());
  }
  void changeBottomSheetState(
      {required bool isShow})
  {
    isBottomSheet = isShow;
    emit(GymChangeBottomSheetState());
  }
}