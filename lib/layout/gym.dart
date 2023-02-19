

import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/logic/authentication_logic/authentication_cubit.dart';
class NewLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState>_key = GlobalKey();
  NewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {

    return BlocConsumer <GymCubit,GymStates>(
      listener: (context, state) {
    },
      builder:(context, state) {
       GymCubit cubit = GymCubit.get(context);
     return  Container(
       width: double.infinity,
       height: double.infinity,
       decoration:const BoxDecoration(
         image:DecorationImage(
           image:AssetImage(
               'assets/images/background1.png'),
           fit:BoxFit. fill,opacity: 12.0, ),),
       child: Scaffold(
            key: _key,
            body: ConditionalBuilder(
              condition:1==1,
              builder:(context) {
                return cubit.screen[cubit.current];
              },
              fallback:(context) =>Center(child:CircularProgressIndicator( color:ColorsManager.primary,)),
            ),
            bottomNavigationBar:
            /*Container(
              height: 75.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color:Color.fromRGBO(65, 65, 65, 1),

              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 11.0,left: 4.0,right: 4.0),
                child:*/
            BottomNavigationBar(
                    currentIndex:  cubit.current,
                    onTap: (index){
                      cubit.changeIndex(index);
                    },
                  items:cubit.bottomItem
                ),
         //     ),
          //  ),
          ),
     );
      },
    );
  }
}
