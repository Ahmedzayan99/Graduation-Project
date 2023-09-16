// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../network/local/cache_helper.dart';

String? uId = '';
const register = '/api/auth/register';
const updateProfile = '/api/updateprofil';
const login = '/api/auth/login';
const muscles = '/api/muscles/all';
const  muscleMuscles = '/api/muscle/exercises/';
const  allExercises = '/api/exercises/all';
const rate = '/api/updateratecoach';
class user{
  static String  getProfile({
    int? id,
  })=>'/api/getprofil/$id';
}
const  api = '/api/plan-by-day/';
class onlyExercises{
   static String  exercises({
          required int? id,
//   String? day
}) => '/api/exercises/$id';
}