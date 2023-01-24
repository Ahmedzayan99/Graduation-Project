import 'package:blackgym/shared/cubit/states.dart';
import 'package:blackgym/shared/widgets/home_training_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/chats.dart';
import '../../modules/exercises.dart';
import '../../modules/home.dart';
import '../../modules/settings.dart';
import '../../modules/workouts.dart';
import '../styles/iconly_broken.dart';

class GymCubit extends Cubit<GymStates> {
  GymCubit() : super(GymInitialState());

  static GymCubit get(context) => BlocProvider.of(context);
  var a;
  bool isBottomSheet = false;
  int current = 0;
  List< BottomNavigationBarItem> bottomitem  = [
     BottomNavigationBarItem(
       icon:Icon(IconlyBroken.home),
      label: 'Home',),
     BottomNavigationBarItem(
       icon:Icon(IconlyBroken.exercise_1),
      label: 'exercises',
    ),
    BottomNavigationBarItem(
      icon:Icon(IconlyBroken.report),
      label: 'Workouts',

    ),
     BottomNavigationBarItem(
      icon: Icon(IconlyBroken.chat
      ),
      label: 'Chat',),
     BottomNavigationBarItem(
      icon: Icon(
        IconlyBroken.setting,
      ),
      label: 'settings',),
];
  List<Widget> screen = [
    const HomeScreen(),
    const ExercisesScreen(),
    const WorkoutsScreen(),
    const ChatScreen(),
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
