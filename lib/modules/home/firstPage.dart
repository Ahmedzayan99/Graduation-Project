// ignore_for_file: file_names

import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login_register/homeSignup.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/abdominal muscles.png'),
                fit: BoxFit.fill, opacity: 210.0,),),
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.only(top: 60.0,right: 20.0,left: 20.0,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/images/Logo.png')),
                    const SizedBox(height: 40.0,),
                    Text("${'ChangeLanguage'.tr(context)}",
                      maxLines:1,
                      style: TextStyle(
                        inherit: false,
                        color:  ColorsManager.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    MaterialButton(
                      height: 54,
                      minWidth: double.infinity,
                      shape: const StadiumBorder(),
                      color: Colors.grey[900],
                      onPressed: () {
                          GymCubit.get(context).changeLanguage(languageCode: 'ar');
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (
                            context, animation, secondaryAnimation) =>
                            const HomeSignUpScreen(),));
                      },
                      child: Row(
                        children: [
                            Icon(Icons.language,color: ColorsManager.primary,  ),
                          const SizedBox(width: 20.0,),
                          Text("اللغه العربيه",
                              style:  TextStyle(
                                inherit: false,
                                color: ColorsManager.primary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0,),
                    MaterialButton(
                      height: 54,
                      minWidth: double.infinity,
                      shape: const StadiumBorder(),
                      color: Colors.grey[900],
                      onPressed: () {
                        GymCubit.get(context).changeLanguage(languageCode: 'en');
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (
                            context, animation, secondaryAnimation) =>
                           const HomeSignUpScreen(),));
                      },
                      child: Row(

                        children: [
                          Icon(Icons.language,color: ColorsManager.primary),
                          const SizedBox(width: 20.0,
                          ) ,
                          Text("English",
                              style:  TextStyle(
                                inherit: false,
                                color: ColorsManager.primary,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
