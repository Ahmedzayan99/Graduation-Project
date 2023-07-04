
// ignore_for_file: avoid_print, must_be_immutable

import 'package:blackgym/layout/home_layout.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/styles/iconly_broken.dart';
import 'package:blackgym/shared/widgets/custom_text_form_filed.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'cubit/authentication_cubit.dart';
import 'cubit/authentication_states.dart';
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
                msg: '${AuthCubit.get(context)!.messageLoginSuccess??'Done Login Success'}',
                backgroundColor: Colors.green,
                textColor: Colors.black,
              );
              GymCubit.get(context).current=0;
              GymCubit.get(context).getNotes();
              Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => NewLayout(),), (route) => false);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image(image: AssetImage('assets/images/Logo.png',)
                          ),
                       SizedBox(width: 2.0,),
                       /*Text("MR GYM",
                    style: TextStyle(
                      inherit: true,
                      color: ColorsManager.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),),*/
                       ],
                    ),
                    const SizedBox(height: 40.0,),
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/Daco_5096993.svg',
                           color: ColorsManager.primary,
                           width: 120.0,
                            height:  120.0,
                          ),
                          const SizedBox(height: 5.0,),
                          Text("Login",
                            style: TextStyle(
                              inherit: true,
                              color: ColorsManager.white,
                              fontSize:30,
                              fontWeight: FontWeight.bold,
                            ),),
                        ],
                      ),
                    ),
                     /* Text("${'loginToYourAccount'.tr(context)}",
                        style: TextStyle(
                          inherit: false,
                          color: ColorsManager.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        )),*/
                    const SizedBox(height: 30.0,),
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
                      textInputType: TextInputType.emailAddress,
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
                    const SizedBox(height: 20.0,),
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
                            cubit.userLogin(email: userNameController.text.trim(),
                                          password: passController.text.trim(),);
                          }
                        },
                        child:  Text("${'logIn'.tr(context)}",
                            style: TextStyle(
                              inherit: false,
                              color:ColorsManager.white,
                              fontSize:20.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
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
