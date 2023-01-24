import 'package:blackgym/modules/login/homeSignup.dart';
import 'package:blackgym/shared/styles/string_manager.dart';
import 'package:flutter/material.dart';

import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import '../../gym.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var userNameController = TextEditingController();
    var passController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/abdominal muscles.png'),
                fit: BoxFit.fill,opacity:150.0),),
        child: Scaffold(
          appBar:AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    Text(AppString.loginToYourAccount,
                        style: TextStyle(
                          inherit: false,
                          color: ColorsManager.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(height: 70,),
                    Text(AppString.userName,
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.primary,
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
                      textInputType: TextInputType.name,
                      icon: IconlyBroken.message,
                    ),
                    const SizedBox(height: 23,),
                    Text(AppString.userName,
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.primary,
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
                      textInputType: TextInputType.name,
                      icon: IconlyBroken.lock,
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
                    MaterialButton(
                      height: 54,
                      minWidth: double.infinity,
                      shape: const StadiumBorder(),
                      color: ColorsManager.primary,
                     onPressed:() {
                        if(_formKey.currentState!.validate()){
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) =>  NewLayout(),), (route) => false);
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
                    const SizedBox(height: 33.0,),
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
                                  MaterialPageRoute(builder: (context) => const HomeSignUpScreen(),)
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
      ),
    );
    }
}
