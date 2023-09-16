
// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blackgym/screens/into_Screen/into_screen.dart';
import 'package:blackgym/screens/layout/layout.dart';
import 'package:blackgym/data/bloc_observer.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/global/app_notifications/notifications.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'cubit/authentication/authentication_cubit.dart';
import 'cubit/exercises/exercises_cubit.dart';
import 'cubit/home/home_cubit.dart';
import 'cubit/layout/layout_cubit.dart';
import 'cubit/notas/notes_cubit.dart';
import 'cubit/settings/settings_cubit.dart';
import 'cubit/workouts/workouts_cubit.dart';
import 'data/network/local/cache_helper.dart';
import 'data/network/remote/dio_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Fluttertoast.showToast(
    msg: "${message.data.toString()}:",
    backgroundColor: Colors.green,
    textColor: Colors.black,
  );
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var tokeni ;
  FirebaseMessaging.instance.getToken().then((value) {
    tokeni = value;
    print(value.toString());
  });
  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
      msg: "${event .data.toString()}",
      backgroundColor: Colors.green,
      textColor: Colors.black,
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    Fluttertoast.showToast(
      msg: '${event .data.toString()}',
      backgroundColor: Colors.green,
      textColor: Colors.black,
    );
  });
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true);
  FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  await NotifyHelper().init();
  var token = CacheHelper.getDataIntoShPre(key: 'token');
  late Widget widget;
  if (token != null) {
    widget = AnimatedSplashScreen(
      splashIconSize: 200,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: ColorsManager.black,
      nextScreen:  NewLayout(),
      splash: 'assets/images/Logo.png',

    );
  }
  else {
    widget = AnimatedSplashScreen(
      splashIconSize: 200,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: ColorsManager.black,
      nextScreen:  HomeIdentifyScreen(),
      splash: 'assets/images/Logo.png',
    );// alignment: AlignmentDirectional.center
  }
  runApp(MyApp(
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => AuthCubit()),
        BlocProvider(create:(context) => LayoutCubit()),
        BlocProvider(create:(context) => HomeCubit()),
        BlocProvider(create:(context) => SettingsCubit()..getUserData()),
        BlocProvider(create:(context) => WorkoutsCubit()..getPlan(day:'${DateFormat('EEEE').format((DateTime.now()))}')),
        BlocProvider(create:(context) => NotesCubit()..getNotes()),
        BlocProvider(create:(context) => ExercisesCubit()..getAllMuscles()),

      ],
        child:ScreenUtilInit(
    designSize: const Size(390, 844),
    minTextAdapt: true,
    splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                locale:  Locale("en"),
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
                home: child,
                theme:getAppThemeData(),
              );

            },
            child:  NewLayout(),
    ),
    );
  }

}

