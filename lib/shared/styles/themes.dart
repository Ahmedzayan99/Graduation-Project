// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors_manager.dart';

ThemeData getAppThemeData() => ThemeData(
       fontFamily:'JosefinSans-Regular',
    scaffoldBackgroundColor:const Color.fromRGBO(255, 255, 255,0),
    //appBar Theme
    appBarTheme:AppBarTheme(
      elevation: 0,
      color:Color.fromRGBO(255, 255, 255,0),
      titleTextStyle: TextStyle(color: ColorsManager.white,fontSize:20.0,fontWeight:FontWeight.bold ),
      systemOverlayStyle:SystemUiOverlayStyle(statusBarColor: Colors.black,
        statusBarIconBrightness:Brightness.light ,
      ),

    ),
    //bottom Sheet theme
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 20.0,
        showDragHandle:true ,
        constraints: BoxConstraints.expand(
            height: 299.0,
            width: double.infinity,
        ),

      backgroundColor:Color.fromRGBO(166, 163, 163, 0.8666666666666667),
      dragHandleColor: ColorsManager.primary,
    ),
    //bottom Navigation theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color.fromRGBO(248, 202, 89, 1),
      backgroundColor:Color.fromRGBO(65, 65, 65, 1),
      type: BottomNavigationBarType.fixed,
      elevation: 0,

    ),

    /// Input Decoration Theme (Text FormFiled)
    ///
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.black,
      suffixIconColor:ColorsManager.primary,
      prefixIconColor: ColorsManager.primary,
      contentPadding: const EdgeInsets.all(8.0),
      hintStyle:  TextStyle(color: ColorsManager.primary,),
      errorStyle: const TextStyle(fontWeight: FontWeight.w300, color: Colors.red, fontSize: 12),

      /// Enable Border
      enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorsManager.primary, width: 1.5),
          borderRadius:  BorderRadius.all(Radius.circular(8))),

      /// Focused Border
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorsManager.primary, width: 1.5),
          borderRadius:  BorderRadius.all(Radius.circular(8))),

      /// Error Border
      errorBorder:  OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8))),

      /// Focused Error Border
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorsManager.primary, width: 1.5),
          borderRadius:  BorderRadius.all(Radius.circular(8))),
    )

);


