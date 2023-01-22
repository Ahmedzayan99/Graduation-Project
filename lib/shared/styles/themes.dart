import 'package:flutter/material.dart';

import 'colors_manager.dart';

ThemeData getAppThemeData() => ThemeData(
    scaffoldBackgroundColor:const Color.fromRGBO(255, 255, 255,0),
    //appBar Theme
    appBarTheme: const AppBarTheme(elevation: 0,
        color:Color.fromRGBO(255, 255, 255,0)),
    //bottom Sheet theme
    bottomSheetTheme:const BottomSheetThemeData(
        elevation: 10.0,
        constraints: BoxConstraints.expand(
            height: 500.0,
            width: double.infinity),
        backgroundColor: Color.fromRGBO(53, 53, 53,0)),
    //bottom Navigation theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color.fromRGBO(248, 202, 89, 1),
      backgroundColor:Color.fromRGBO(65, 65, 65, 1),
      type: BottomNavigationBarType.fixed,
      elevation: 0,

    ),
    /// Input Decoration Theme (Text FormFiled)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      prefixIconColor: ColorsManager.primary,
      contentPadding: const EdgeInsets.all(8.0),
      errorStyle: const TextStyle(fontWeight: FontWeight.w300, color: Colors.red, fontSize: 12),

      /// Enable Border
      enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorsManager.primary, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8))),

      /// Focused Border
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorsManager.primary, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8))),

      /// Error Border
      errorBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8))),

      /// Focused Error Border
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorsManager.primary, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
    ));
