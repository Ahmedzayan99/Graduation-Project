// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../modules/login_register//homeSignup.dart';
import '../network/local/cache_helper.dart';

String? uId = '';
 const login = '/api/auth/login';

//final GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();

// Function For Navigate To Other Screens And Cant Return
void signOut(context)
{
  CacheHelper.removeUserData(
      key: 'uId').
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