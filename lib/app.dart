import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:blackgym/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
//  final AppRouter appRouter;
  final Widget? startWidget;
  const MyApp({Key? key,
    // required this.appRouter,
    required this.startWidget
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => GymCubit()..getAllUser()),
        BlocProvider(create:(context) => AuthCubit()),
      ],
      child: BlocConsumer<GymCubit,GymStates>(
        listener: (context, state) {},
        builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            //startWidget ,
            theme: getAppThemeData(),

          );
        },
      ),
    );
  }
}
