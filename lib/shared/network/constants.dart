// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../modules/login_register//homeSignup.dart';
import '../network/local/cache_helper.dart';

String? uId = '';
const register = '/api/auth/register';
const updateProfil = '/api/updateprofil';
 const login = '/api/auth/login';
const muscles = '/api/muscles/all';
const  OonlyMuscles = '/api/muscle/exercises/';
const  alllexercises = '/api/exercises/all';
//const  user = '/api/getprofil/83';
class user{
  static String  oneUser({
    int? id,
  })=>'/api/getprofil/$id';
}
const  api = '/api/plan-by-day/61/Friday';
class onlyexercises{
  static String  exercises({
          required int? id,
//   String? day
}) => '/api/exercises/$id';
/*class api{
  static String  plan({
    // int? id,
  //   String? day
  }) => '/api/plan-by-day/49/Friday';
}*/

//final GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();

// Function For Navigate To Other Screens And Cant Return
void signOut(context)
{
  CacheHelper.removeUserData(
      key: 'token').
  then((value)
  {
    if (value!)
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeSignUpScreen()),
    );
    }
  });
}
}