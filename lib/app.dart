import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:blackgym/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
//  final AppRouter appRouter;
  final Widget? startWidget;
  final String lang;
  const MyApp({Key? key,
    required this.startWidget,
    required this.lang
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => GymCubit()..changeLanguage(languageCode: lang)..getAllUser()),
        BlocProvider(create:(context) => AuthCubit()),
      ],
      child: BlocConsumer<GymCubit,GymStates>(
        listener: (context, state) {},
        builder:(context, state) {
          return MaterialApp(
            locale:
            GymCubit.get(context).lang =="en" ? const Locale("en"):const Locale("ar"),
            supportedLocales: const [
              Locale("en"),
              Locale("ar"),
            ],
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
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
            theme: getAppThemeData(),

          );
        },
      ),
    );
  }
}
