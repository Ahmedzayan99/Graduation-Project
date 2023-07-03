import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'modules/login/cubit/authentication_cubit.dart';
class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({Key? key,
    required this.startWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => GymCubit()..getUserData()..getAllMuscles()..getOnlyMuscles()..getNotes()..checkInternet()),
        BlocProvider(create:(context) => AuthCubit()),
      ],
      child: BlocConsumer<GymCubit,GymStates>(
        listener: (context, state) {},
        builder:(context, state) {
          return MaterialApp(
            locale: GymCubit.get(context).lang =="en" ? const Locale("en"):const Locale("ar"),
            supportedLocales: const [
              Locale("en"),
              Locale("ar"),
            ],
            localizationsDelegates: const [
              AppLocalization.delegate,
              // GlobalMaterialLocalizations.delegate,
           //   GlobalWidgetsLocalizations.delegate,
           //   GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (currentLang, supportLang) {

              for (Locale locale in supportLang) {
                if (currentLang != null && locale.languageCode == currentLang.languageCode) {
                  return currentLang;
                }
              }
              return supportLang.first;
            },
            debugShowCheckedModeBanner: false,
            home: startWidget,
            //startWidget ,
            theme:getAppThemeData(),
          );
        },
      ),
    );
  }
}
