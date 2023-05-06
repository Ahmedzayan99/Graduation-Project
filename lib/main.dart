// ignore_for_file: prefer_const_constructors, avoid_print


import 'package:blackgym/app.dart';
import 'package:blackgym/shared/bloc_observer.dart';
import 'package:blackgym/shared/global/app_notifications/notifications.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'modules/changeLanuage.dart';
import 'modules/gym.dart';

// إنشاء كائن FlutterLocalNotificationsPlugin
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  await NotifyHelper().init().then((value){
    print('Start NotifyHelper');
  }).catchError((Error){
    print('Error NotifyHelper${Error.toString()}');
  });
  // bool? onBoarding = CacheHelper.getDataIntoShPre(key: 'Onboarding');
  var lang = CacheHelper.getDataIntoShPre(key: 'Lang');
  var token = CacheHelper.getDataIntoShPre(key: 'token');
  var userModel = CacheHelper.getDataIntoShPre(key: 'userModel');

  if (lang != null) {
    lang = lang;
  } else {
    lang = 'en';
  }
  late Widget widget;
  if (token != null) {
    widget = NewLayout();
    print(userModel);
  } else {
    widget = ChangeLanguageScreen();
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
    //token: token,
  ));
}
