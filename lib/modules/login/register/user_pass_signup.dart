// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/styles/string_manager.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import 'detiles_signup.dart';

class SignupUserScreen extends StatelessWidget {
  SignupUserScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var userNameController = TextEditingController();
  var passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Container(
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
                    textInputType: TextInputType.name,
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
                    controller:passController ,
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    icon: IconlyBroken.lock,
                    hintText: AppString.enterYourPassword,
                  ),
                  const SizedBox(height: 30.0,),
                  MaterialButton(
                    height: 54,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    color: ColorsManager.primary,
                    onPressed: () {
                //      if(_formKey.currentState!.validate())
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignupDetilesScreen(),), (route) => false);
                    },
                    child:  const Text('Next',
                        style:TextStyle(
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
        ),
      ),
    );
  }
}
