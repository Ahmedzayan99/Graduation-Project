
// ignore_for_file: avoid_print, must_be_immutable

import 'package:blackgym/modules/gym.dart';
import 'package:blackgym/modules/login_register/cubit/authentication_cubit.dart';
import 'package:blackgym/modules/login_register/cubit/authentication_states.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/styles/iconly_broken.dart';
import 'package:blackgym/shared/widgets/custom_text_form_filed.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../register/second_step_register.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
   var userNameController = TextEditingController();
   var passController = TextEditingController();
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
          listener: (context, state) {
            if(state is LoginErrorState){
              Fluttertoast.showToast(
                msg: "${'usernamePasswordIncorrect'.tr(context)}",
                backgroundColor: Colors.red,
                textColor: Colors.black,
              );
            }
            if(state is LoginSuccessState){
              Fluttertoast.showToast(
                msg: "${'doneSuccessfully'.tr(context)}",
                backgroundColor: Colors.white,
                textColor: Colors.black,
              );
              GymCubit.get(context).current =0;
              Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>  NewLayout(),), (route) => false);

            }
          },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
      return  Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/abdominal muscles.png'),
                fit: BoxFit.fill,opacity:150.0),),
        child: Scaffold(
          appBar:AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:
                  [
                    Text("${'loginToYourAccount'.tr(context)}",
                        style: TextStyle(
                          inherit: false,
                          color: ColorsManager.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(height: 40,),
                    Text("${'userName'.tr(context)}",
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.white,
                        fontSize: 16,

                        fontWeight: FontWeight.w700,
                      ),),
                    CustomTextFormFiled(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "${'thisFieldRequired'.tr(context)}";
                        }
                        return null;
                      },
                      controller: userNameController,
                      hintText:"${'userName'.tr(context)}",
                      textInputType: TextInputType.name,
                      icon:const Icon(IconlyBroken.message,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Text("${'password'.tr(context)}",
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),),
                    CustomTextFormFiled(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "${'thisFieldRequired'.tr(context)}";

                        }
                        return null;
                      },
                      controller: passController,
                      textInputType: TextInputType.visiblePassword,
                      icon:const Icon(IconlyBroken.lock,),
                      isPassword:AuthCubit.get(context).isPasswordLogin,
                      hintText:"${'password'.tr(context)}",
                      suffixIcon: AuthCubit.get(context).iconPasswordLogin,
                      suffixOnPressed: (){
                        AuthCubit.get(context).changePasswordLoginVisible();
                      },
                    ),
                  /**  Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                          onPressed: () {
                        Navigator.push( context,
                            MaterialPageRoute(builder: (context) => const HomeSignUpScreen(),)
                        );
                      },
                          child: Text( "${'forgetThePassword'.tr(context)}",
                              style: TextStyle(
                                inherit: false,
                                color:ColorsManager.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ))),
                    ),**/
                    const SizedBox(height: 13.0,),
                    ConditionalBuilder(
                      condition:state is!LoginLoadingState,
                      fallback: (context) =>  defaultProgressIndicator(),
                      builder:(context) =>  MaterialButton(
                        height: 54,
                        minWidth: double.infinity,
                        shape: const StadiumBorder(),
                        color: ColorsManager.primary,
                        onPressed:() {
                          if(_formKey.currentState!.validate())
                          {
                          //  cubit.userLogin(
                            //  email: userNameController.text,
                              //password: passController.text,
                           // );
                            cubit.userLogin(email: userNameController.text.trim(),
                                          password: passController.text.trim(),);
                          }
                        },
                        child:  Text("${'logIn'.tr(context)}",
                            style: TextStyle(
                              inherit: false,
                              color:ColorsManager.black,
                              fontSize:20.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text("${'dontHaveAnAccount'.tr(context)}",
                            maxLines: 1,
                            style: TextStyle(
                              inherit: false,
                              color:ColorsManager.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push( context,
                                  MaterialPageRoute(builder: (context) => SignupUserScreen(),)
                              );
                            },
                            child: Text("${'signUp'.tr(context)}",
                                maxLines: 1,
                                style: TextStyle(
                                  inherit: false,
                                  color: ColorsManager.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      });
  }
}
