
import 'package:blackgym/shared/bloc_observer.dart';
import 'package:blackgym/shared/cubit/cubit.dart';
import 'package:blackgym/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/login/homeSignup.dart';
import 'shared/styles/themes.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GymCubit(),
      child: BlocConsumer<GymCubit,GymStates>(
        listener: (context, state) {},
        builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:  const HomeSignUpScreen(),
            theme: getAppThemeData(),
          );
        },
      ),
    );
  }
}
