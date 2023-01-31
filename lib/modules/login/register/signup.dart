// ignore_for_file: must_be_immutable

import 'package:blackgym/modules/login/register/user_pass_signup.dart';
import 'package:flutter/material.dart';

import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/string_manager.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';

class SignupScreen extends StatelessWidget {
 SignupScreen({Key? key}) : super(key: key);
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppString.phoneNumber,
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
                  textInputType: TextInputType.phone,
                  icon: Icons.phone,
                  hintText: AppString.enterPhoneNumber,
                ),
                const SizedBox(height: 30.0,),
                MaterialButton(
                  height: 54,
                  minWidth: double.infinity,
                  shape: const StadiumBorder(),
                  color: ColorsManager.primary,
                  onPressed: () {
                  //  if(_formKey.currentState!.validate())
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignupUserScreen(),), (route) => false);
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
    );
  }
}
