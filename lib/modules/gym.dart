

import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/styles/iconly_broken.dart';
class NewLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState>_key = GlobalKey();
  NewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {

    return BlocBuilder <GymCubit,GymStates>(
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
            body:cubit.screen[cubit.current],
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
                  currentIndex:  cubit.current,
                  onTap: (index){
                    cubit.changeIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(IconlyBroken.home),
                      label: "${'home'.tr(context)}",
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(IconlyBroken.exercise_1),
                      label:  "${'exercises'.tr(context)}",
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(IconlyBroken.report),
                      label:  "${'workouts'.tr(context)}",
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(IconlyBroken.chat),
                      label:  "${'notes'.tr(context)}",
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(
                        IconlyBroken.setting,
                      ),
                      label:"${'settings'.tr(context)}",
                    ),


                  ]
              ),

       ),
     );
      },
    );
  }}
/*


 floatingActionButton:
         FloatingActionButton(
           onPressed: () {  },
           mini: true,
           child: Icon(cubit.iconShow),),


 BottomAppBar(
              color: Color.fromRGBO(65, 65, 65, 1),
              shape: CircularNotchedRectangle(),
               notchMargin: 5.0,clipBehavior: Clip.antiAliasWithSaveLayer,



Container(
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


