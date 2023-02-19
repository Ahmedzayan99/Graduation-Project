// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/styles/string_manager.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import 'details_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_states.dart';
class SignupUserScreen extends StatelessWidget {
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
                        Text(AppString.name,
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
                              return AppString.thisFiledFree;
                            }
                            return null;
                          },
                          controller:nameController ,
                          textInputType: TextInputType.name,
                          icon: IconlyBroken.profile,
                          hintText:'Enter Your ${AppString.name}',
                        ),
                        const SizedBox(height: 30.0,),
                        Text(AppString.userName,
                          style: TextStyle(
                            inherit: false,
                            color: ColorsManager.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                        CustomTextFormFiled(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return AppString.thisFiledFree;
                            }
                            return null;
                          },
                          controller:userNameController ,
                          textInputType: TextInputType.emailAddress,
                          icon: IconlyBroken.message,
                          hintText:AppString.enterUserName,
                        ),
                        const SizedBox(height: 30.0,),
                        Text(AppString.password,
                          style: TextStyle(
                            inherit: false,
                            color: ColorsManager.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                        CustomTextFormFiled(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return AppString.thisFiledFree;
                            }
                            return null;
                          },
                          controller: passController,
                          textInputType: TextInputType.visiblePassword,
                          icon: IconlyBroken.lock,
                          isPassword:AuthCubit.get(context).isPasswordRegister,
                          hintText:AppString.enterYourPassword,
                          suffixOnPressed: (){
                            AuthCubit.get(context).changePasswordRegisterVisible();
                          },
                          suffixIcon: AuthCubit.get(context).iconPasswordRegister,
                        ),
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition:state is!RegisterLoadingState,
                          fallback: (context) =>  Center(child:CircularProgressIndicator(color:ColorsManager.primary,)),
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
                                            SignupDetailsScreen(email:userNameController.text ,
                                              name:nameController.text,
                                              password:passController.text,
                                              phone:phone,
                                            ),), (route) => false);
                                  }
                                },
                                child:  const Text('Next',
                                    style:TextStyle(
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
