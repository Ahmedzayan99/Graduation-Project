
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../screens/exercises/exercises.dart';
import '../../screens/home/home.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  get index => null;

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> homeImagesModel = [
    const Image(image: AssetImage('assets/images/gym.jpg')),
    const Image(image: AssetImage('assets/images/back.jpg')),
    const Image(image: AssetImage( 'assets/images/sixbacks.jpg')),
    const Image(image: AssetImage('assets/images/bye.jpg')),
  ];


}