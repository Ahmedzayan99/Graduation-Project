import 'package:blackgym/app.dart';
import 'package:blackgym/shared/bloc_observer.dart';
import 'package:blackgym/shared/network/constants.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/gym.dart';
import 'modules/home/firstPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  //DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

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
    widget = const ChangeLanguageScreen();

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
