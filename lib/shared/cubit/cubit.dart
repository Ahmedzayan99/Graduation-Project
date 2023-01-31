import 'package:blackgym/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/login/chat/chats.dart';
import '../../modules/exercises.dart';
import '../../modules/home.dart';
import '../../modules/settings.dart';
import '../../modules/workouts.dart';
import '../styles/iconly_broken.dart';

class GymCubit extends Cubit<GymStates> {
  GymCubit() : super(GymInitialState());

  static GymCubit get(context) => BlocProvider.of(context);
  bool isBottomSheet = false;
  int current = 0;
  List< BottomNavigationBarItem> bottomItem  = [
     const BottomNavigationBarItem(
       icon:Icon(IconlyBroken.home),
      label: 'Home',),
     const BottomNavigationBarItem(
       icon:Icon(IconlyBroken.exercise_1),
      label: 'exercises',
    ),
    const BottomNavigationBarItem(
      icon:Icon(IconlyBroken.report),
      label: 'Workouts',

    ),
     const BottomNavigationBarItem(
      icon: Icon(IconlyBroken.chat
      ),
      label: 'Chat',),
     const BottomNavigationBarItem(
      icon: Icon(
        IconlyBroken.setting,
      ),
      label: 'settings',),
];
  List<Widget> screen = [
     HomeScreen(),
    const ExercisesScreen(),
    const WorkoutsScreen(),
    const ChatScreen(),
    SettingsScreen(),
  ];
  void changeIndex(int index) {
    current = index;
    emit(GymChangeBottomNavBarState());
  }
  void changeBottomSheetState({required bool isShow})
  {
    isBottomSheet = isShow;
    emit(GymChangeBottomSheetState());
  }
  bool myProfile=false;
  void changeBottomProfile(){
    myProfile =!myProfile;
    emit(GymChangeProfileState());
  }
  bool language=false;
  void changeBottomLanguage(){
    language =!language;
    emit(GymChangeProfileState());
  }
  bool selectLanguage=true;
  void changeBottomSelectLanguage(){
    selectLanguage =!selectLanguage;
    emit(GymInitialState());
  }
}
