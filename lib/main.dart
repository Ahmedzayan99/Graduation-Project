
// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blackgym/app.dart';
import 'package:blackgym/shared/bloc_observer.dart';
import 'package:blackgym/shared/global/app_notifications/notifications.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'layout/home_layout.dart';
import 'package:flutter_svg/svg.dart';

import 'layout/home_login.dart';
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
    startWidget: widget,
  ));
}