// ignore_for_file: file_names

import 'package:blackgym/modules/login/login/login.dart';
import 'package:blackgym/modules/login/register/fisrst_step_register.dart';
import 'package:blackgym/shared/styles/string_manager.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/colors_manager.dart';
class HomeSignUpScreen extends StatelessWidget {
  const HomeSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/abdominal muscles.png'),
            fit: BoxFit.fill,opacity: 150.0,),),
      child: Scaffold(
        appBar: AppBar(),
        body:Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             crossAxisAlignment: CrossAxisAlignment.center,
             children:[
               SizedBox(
                 child: Column(

                   children:
                   [
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
                       child: Text(AppString.becomeStrongerWithOurWorkoutPlans,
                       maxLines: 2,
                       style:TextStyle(
                         inherit: false,
                         color:ColorsManager.white,
                         fontSize: 20.0,
                         fontWeight: FontWeight.bold,
                       ),
                   ),
                     ),
                 const SizedBox(height: 10.0,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                   child: Text(AppString.throughThisApplicationYourHealth,
                     maxLines: 4,
                     style:TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize:14.0,
                       fontWeight: FontWeight.w400,
                     ),),
                 ),],
                 ),
               ),
               const SizedBox(height: 30.0,),
               MaterialButton(
                 height: 54,
                 minWidth: double.infinity,
                 shape: const StadiumBorder(),
                 color: ColorsManager.primary,
                 onPressed: () {
                   Navigator.push(context, PageRouteBuilder(pageBuilder:(context, animation, secondaryAnimation) => LoginScreen(),));
                 },
                 child:  Text(AppString.logIn,
                     style:const TextStyle(
                       inherit: false,
                       color:Colors.black,
                       fontSize:20.0,
                       fontWeight: FontWeight.bold,
                     )),
               ),
               const SizedBox(height: 25.0,),
               MaterialButton(
                 height: 54,
                 minWidth: double.infinity,
                 shape: const StadiumBorder(),
                 color: ColorsManager.primary,
                 onPressed: () {
                   Navigator.push(context, PageRouteBuilder(pageBuilder:(context, animation, secondaryAnimation) => SignupScreen(),));

                 },
                 child:  Text(AppString.signUp,
                     style:const TextStyle(
                       inherit: false,
                       color:Colors.black,
                       fontSize:20.0,
                       fontWeight: FontWeight.bold,
                     )),
               ),
             ],

           ),
         ),
      ),
    );
  }
}
