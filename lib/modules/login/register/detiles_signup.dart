// ignore_for_file: must_be_immutable

import 'package:blackgym/modules/gym.dart';
import 'package:flutter/material.dart';

import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/styles/string_manager.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';

class SignupDetilesScreen extends StatelessWidget {
  SignupDetilesScreen({Key? key}) : super(key: key);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(

                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(50.0),border:Border.all(color: ColorsManager.primary,),
                      ),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: ColorsManager.black,
                        child: Icon(
                          color:ColorsManager.primary,
                          IconlyBroken.camera,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    AppString.height,
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
                    hintText: 'Enter your ${AppString.height}',
                  ),
                  const SizedBox(
                    height: 30.0,),

                  Text(
                    AppString.weight,
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
                    hintText: 'Enter your ${AppString.weight}',
                  ),
                  const SizedBox(height: 30.0,),

                  Text(
                    AppString.age,
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
                    textInputType: TextInputType.visiblePassword,
                    icon: IconlyBroken.lock,
                    hintText: 'Enter your ${AppString.age}',
                  ),
                  const SizedBox(height: 30.0,),
                  Text(
                    AppString.fatPercentage,
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
                    hintText: 'Enter your ${AppString.fatPercentage}',
                  ),
                  const SizedBox(height: 30.0,),

                  MaterialButton(
                    height: 54,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    color: ColorsManager.primary,
                    onPressed: () {
                      //      if(_formKey.currentState!.validate())
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NewLayout(),), (route) => false);
                    },
                    child:  const Text('Finish',
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
