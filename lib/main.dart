// ignore_for_file: prefer_const_constructors

import 'package:blackgym/app.dart';
import 'package:blackgym/shared/bloc_observer.dart';
import 'package:blackgym/shared/network/constants.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'layout/gym.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  // bool? onBoarding = CacheHelper.getDataIntoShPre(key: 'Onboarding');
  uId = CacheHelper.getDataIntoShPre(key: 'uId');
  var lang = CacheHelper.getDataIntoShPre(key: 'Lang');

  if (lang != null) {
    lang = lang;
  } else {
    lang = 'en';
  }
  late Widget widget;
  if (uId != null) {
    widget = NewLayout();
  } else {
    widget =  NewLayout();

  }

  //FirebaseAuth.instance.authStateChanges().listen((user) {
  //if (user == null) {
  //    initialRoute = loginScreen;
  //   } else {
  //   initialRoute = newLayout;
  //  }
  //});

  runApp(MyApp(
    //appRouter: AppRouter()
    startWidget: widget,
    lang: lang,
  ));
}
