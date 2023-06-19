// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../modules/login_register//homeSignup.dart';
import '../network/local/cache_helper.dart';

String? uId = '';
const register = '/api/auth/register';
 const login = '/api/auth/login';
const muscles = '/api/muscles/all';
const  OonlyMuscles = '/api/muscle/exercises/';
const  user = '/api/auth/user/41';
class api{
  static String  plan({
     int? id,
     String? day
  }) => '/api/plan-by-day/$id/$day';
}

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