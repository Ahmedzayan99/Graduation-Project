
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/layout/layout_cubit.dart';
import '../../cubit/layout/layout_states.dart';
import '../../shared/styles/iconly_broken.dart';

class NewLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState>_key = GlobalKey();
  NewLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)  {
    return BlocBuilder <LayoutCubit,LayoutStates>(
      builder:(context, state) {
        var cubit = LayoutCubit.get(context);
        return  Container(
          width: double.infinity,
          height: double.infinity,
          decoration:const BoxDecoration(
            image:DecorationImage(
              image:AssetImage(
                  'assets/images/background1.png'),
              fit:BoxFit. fill,opacity: 180.0, ),),
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

