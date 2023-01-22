import 'package:blackgym/modules/login/homeSignup.dart';
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
    return Container(
      key: _formKey,
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
                  const Text('Login to your Account',
                      style: TextStyle(
                        inherit: false,
                        color: Color.fromRGBO(243, 243, 242, 1.0),
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 70,),
                  CustomTextFormFiled(
                    controller: userNameController,
                    textInputType: TextInputType.name,
                    icon: IconlyBroken.message,
                  ),
                  const SizedBox(height: 23,),
                  CustomTextFormFiled(
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
                        child:const Text('Forget the password?',
                            style: TextStyle(
                              inherit: false,
                              color: Color.fromRGBO(248, 202, 89, 1),
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
                    onPressed: () {

                    },
                    child: const Text(' Sign In',
                        style:TextStyle(
                          inherit: false,
                          color:Colors.white,
                          fontSize:20.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 33.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?',
                          maxLines: 1,
                          style: TextStyle(
                            inherit: false,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.push( context,
                                MaterialPageRoute(builder: (context) => const HomeSignUpScreen(),)
                            );
                          },
                          child:const Text('Sign up',
                              maxLines: 1,
                              style: TextStyle(
                                inherit: false,
                                color: Color.fromRGBO(248, 202, 89, 1),
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
    }
}
