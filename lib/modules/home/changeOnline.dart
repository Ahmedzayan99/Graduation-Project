// ignore_for_file: file_names

import 'package:blackgym/modules/login_register/register/fisrst_step_register.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_states.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePlaceScreen extends StatelessWidget {
  const ChangePlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/abdominal muscles.png'),
                fit: BoxFit.fill, opacity: 150.0,),),
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Column(
                        children:
                        [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0),
                            child: Text("${'chooseTheWayWant..'.tr(context)}",
                              maxLines: 2,
                              style: TextStyle(
                                inherit: false,
                                color: ColorsManager.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0),
                            child: Text("${'willYouTrainIn..'.tr(context)}",
                              maxLines: 4,
                              style: TextStyle(
                                inherit: false,
                                color: ColorsManager.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    MaterialButton(
                      height: 54,
                      minWidth: double.infinity,
                      shape: const StadiumBorder(),
                      color: ColorsManager.primary,
                      onPressed: () {
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (
                            context, animation, secondaryAnimation) =>
                            SignupScreen(),));
                      },
                      child: Text("${'online'.tr(context)}",
                          style: const TextStyle(
                            inherit: false,
                            color: Colors.black,
                            fontSize: 20.0,
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
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (
                            context, animation, secondaryAnimation) =>
                            SignupScreen(),));
                      },
                      child: Text("${'inYourGym'.tr(context)}",
                          style: const TextStyle(
                            inherit: false,
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
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