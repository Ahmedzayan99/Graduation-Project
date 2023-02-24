// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:blackgym/shared/components.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import 'details_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_states.dart';
class SignupUserScreen extends StatelessWidget{
  String phone;
  SignupUserScreen({Key? key, required this.phone,}) : super(key: key);
  var nameController = TextEditingController();
  var userNameController = TextEditingController();
  var passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/abdominal muscles.png'),
                  fit: BoxFit.fill,opacity: 150.0),),
            child: Scaffold(
              appBar:AppBar(),
              body:Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${'name'.tr(context)}",
                          style: TextStyle(
                            inherit: false,
                            color: ColorsManager.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                        CustomTextFormFiled(
                          isPassword: false,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "${'thisFieldRequired'.tr(context)}";
                            }
                            return null;
                          },
                          controller:nameController ,
                          textInputType: TextInputType.name,
                         icon:const Icon(IconlyBroken.profile,) ,
                          hintText:"${'name'.tr(context)}",
                        ),
                        const SizedBox(height: 30.0,),
                        Text("${'userName'.tr(context)}",
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
                            else if(!RegExp(r"^[Aa-z-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]").hasMatch(p0))
                            {
                              return 'aaaaaaaaaaaa';
                            }
                            return null;
                          },
                          controller:userNameController ,
                          textInputType: TextInputType.emailAddress,
                          icon:const Icon(IconlyBroken.message,) ,
                          hintText:"${'userName'.tr(context)}",
                        ),
                        const SizedBox(height: 30.0,),
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
                            else if (p0.trim().length < 8) {
                              return 'Password must be at least 8 characters in length';
                            }
                            return null;
                          },
                          controller: passController,
                          textInputType: TextInputType.visiblePassword,
                          icon: const Icon(IconlyBroken.lock),
                          isPassword:AuthCubit.get(context).isPasswordRegister,
                          hintText:"${'password'.tr(context)}",
                          suffixOnPressed: (){
                            AuthCubit.get(context).changePasswordRegisterVisible();
                          },
                          suffixIcon: AuthCubit.get(context).iconPasswordRegister,
                        ),
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition:state is!RegisterLoadingState,
                          fallback: (context) => defaultProgressIndicator(),
                          builder:(context) =>
                              MaterialButton(
                                height: 54,
                                minWidth: double.infinity,
                                shape: const StadiumBorder(),
                                color: ColorsManager.primary,
                                onPressed: () {

                                  if(_formKey.currentState!.validate())
                                  {
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) =>
                                            SignupDetailsScreen(
                                              email:userNameController.text.trim() ,
                                              name:nameController.text,
                                              password:passController.text,
                                              phone:phone,
                                            ),), (route) => false);
                                  }
                                },
                                child:   Text("${'next'.tr(context)}",
                                    style:const TextStyle(
                                      inherit: false,
                                      color:Colors.black,
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
