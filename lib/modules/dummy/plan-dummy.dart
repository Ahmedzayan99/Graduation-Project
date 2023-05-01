// ignore_for_file: file_names

import 'package:blackgym/model/chat_model.dart';

List<Plan> plans =[
  Plan(
  date:DateTime.now(),
    uId:'ssss',
    play: [
      plays(
      uId: 'sss',
      image:'assets/images/SITUP exercise.png',
      set: 2,
      )
      ]
    ),
  Plan(
    uId:'dd' ,
    date:DateTime(2023,4,20,0,0,0,0,0) ,
    play:[
      plays(
        uId: 'sss',
        image:'assets/images/SITUP exercise.png',
        set: 2,
      )
    ],
  ),
  Plan(
    uId:'dd' ,
    date:DateTime.now() ,
    play:[
      plays(
        uId: 'sss',
        image:'assets/images/SITUP exercise.png',
        set: 2,
      )
    ],
  ),
];