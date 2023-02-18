
import 'package:blackgym/modules/login/homeSignup.dart';
import 'package:blackgym/shared/styles/string_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import '../../../layout/gym.dart';
import '../register/fisrst_step_register.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
   var userNameController = TextEditingController();
   var passController = TextEditingController();

   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GymCubit,GymStates>(
          listener: (context, state) {
            if(state is GymLoginErrorState){
              Fluttertoast.showToast(
                msg: 'The username or password is incorrect',
                backgroundColor: Colors.red,
                textColor: Colors.black,
              );

              print(state.error);
            }
            if(state is GymLoginSuccessState){
              Fluttertoast.showToast(
                msg: 'Login successfully',
                backgroundColor: Colors.white,
                textColor: Colors.black,
              );
              CacheHelper.saveData(
                  key: 'uId',
                  value:state.uId)
                  .then((value) =>
              {
                GymCubit.get(context).getUserData(),
              Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>  NewLayout(),), (route) => false),
              });

            }
          },
      builder: (context, state) {
        GymCubit cubit = GymCubit.get(context);
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
                    Text(AppString.loginToYourAccount,
                        style: TextStyle(
                          inherit: false,
                          color: ColorsManager.white,
                          fontSize: 40,

                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(height: 70,),
                    Text(AppString.userName,
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.white,
                        fontSize: 16,

                        fontWeight: FontWeight.w700,
                      ),),
                    CustomTextFormFiled(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.thisFiledFree;
                        }
                        return null;
                      },
                      controller: userNameController,
                      hintText:'${AppString.enterUserName} or ${AppString.password}',
                      textInputType: TextInputType.name,
                      icon: IconlyBroken.message,
                    ),
                    const SizedBox(height: 30,),
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
                      isPassword:GymCubit.get(context).isPasswordLogin,
                      hintText:AppString.enterYourPassword,
                      suffixIcon: GymCubit.get(context).iconPasswordLogin,
                      suffixOnPressed: (){
                        GymCubit.get(context).changePasswordLoginVisible();
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                          onPressed: () {
                        Navigator.push( context,
                            MaterialPageRoute(builder: (context) => const HomeSignUpScreen(),)
                        );
                      },
                          child: Text( AppString.forgetThePassword,
                              style: TextStyle(
                                inherit: false,
                                color:ColorsManager.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ))),
                    ),
                    const SizedBox(height: 13.0,),
                    ConditionalBuilder(
                      condition:state is!GymLoginLoadingState,
                      fallback: (context) =>  Center(child:CircularProgressIndicator(color:ColorsManager.primary,)),
                      builder:(context) =>  MaterialButton(
                        height: 54,
                        minWidth: double.infinity,
                        shape: const StadiumBorder(),
                        color: ColorsManager.primary,
                        onPressed:() {
                          if(_formKey.currentState!.validate())
                          {
                            cubit.userLogin(
                              email: userNameController.text,
                              password: passController.text,
                            );


                          }
                        },
                        child:  Text(AppString.logIn,
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
                         Text(AppString.dontHaveAnAccount,
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
                                  MaterialPageRoute(builder: (context) => SignupScreen(),)
                              );
                            },
                            child: Text(AppString.logIn,
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
