import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home/home_cubit.dart';
import '../../cubit/home/home_states.dart';
import '../../cubit/layout/layout_cubit.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
       return  Padding(
         padding:const EdgeInsetsDirectional.only(top: 90.0),
         child: Scaffold(
             body: Padding(
               padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       DefaultTextStyle(
                         style: const TextStyle(
                             fontSize: 40,
                             color: Colors.white60,
                             fontWeight: FontWeight.w800),
                         child: AnimatedTextKit(
                           animatedTexts: [
                             WavyAnimatedText("${'welcome'.tr(context)}",
                                 speed: const Duration(milliseconds: 700)),
                           ],
                           totalRepeatCount: 100,
                           pause: const Duration(milliseconds: 9000),
                           isRepeatingAnimation: true,
                           onTap: () {
                             // print("Tap Event");
                           },
                         ),
                       )
                     ],
                   ),
                   Center(
                     child: SizedBox(
                       height: 300.0,
                       width: 500.0,
                       child: CarouselSlider(
                         items:HomeCubit.get(context).homeImagesModel,
                         options: CarouselOptions(
                           viewportFraction:1.0 ,
                           height: 250,
                           initialPage: 0,
                           scrollDirection: Axis.horizontal,
                           enableInfiniteScroll: true,
                           reverse: false,
                           autoPlay: true,
                           autoPlayInterval: const Duration(seconds:3),
                           autoPlayAnimationDuration:const Duration(seconds:1),
                           autoPlayCurve:Curves.fastOutSlowIn,
                         ),

                       ),
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       AnimatedTextKit(
                         animatedTexts: [
                           TypewriterAnimatedText(
                             "${'neverGiveUp'.tr(context)}",
                             textStyle: const TextStyle(
                                 fontSize: 32.0,
                                 fontWeight: FontWeight.w800,
                                 color: Colors.white),
                             speed: const Duration(milliseconds: 400),
                           ),
                         ],
                         totalRepeatCount: 100,
                         pause: const Duration(milliseconds: 1000),
                         displayFullTextOnTap: true,
                         stopPauseOnTap: true,
                       )
                     ],
                   ),
                   const SizedBox(
                     height: 50.0,
                   ),
                   Row(
                     children:  [
                       Expanded(
                           child: Row(
                             children: [
                               Expanded(
                                 child: Text(
                                   "${'loseWeightBuildMuscle'.tr(context)} .",
                                   style: TextStyle(
                                       fontSize: 22,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold),
                                   maxLines: 1,
                                 ),
                               ),
                               Icon(IconlyBroken.exercise_1,color: ColorsManager.primary,)
                             ],
                           )
                       )
                     ],
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   Spacer(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       TextButton(
                         style: TextButton.styleFrom(
                           textStyle: const TextStyle(fontSize: 30),
                         ),
                         onPressed: () {
                           //   print(HomeCubit.get(context).taskList.toString());
                           //           Navigator.push(context,
                           //   MaterialPageRoute(builder: (context) =>TaskListPage(),),);
                           LayoutCubit.get(context).changeIndex(1);
                         },
                         child:  Text(
                           "${'letsStart'.tr(context)}",
                           style: TextStyle(
                               color: Colors.yellow, fontWeight: FontWeight.w600),
                         ),
                       )
                     ],
                   ),
                 ],
               ),
             )
         ),
       );
      },
    );
  }
}
