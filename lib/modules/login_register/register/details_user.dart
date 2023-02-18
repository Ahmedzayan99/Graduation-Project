// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:blackgym/layout/gym.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/styles/string_manager.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';

class SignupDetailsScreen extends StatelessWidget {
   String email;
   String name;
   String password;
   String phone;
   SignupDetailsScreen({ Key? key,
    required this.email,
    required this.name,
    required this.password,
     required this.phone,

   }) : super(key: key);
  var heightController = TextEditingController();
  var weightController = TextEditingController();
   var ageController = TextEditingController();
   var genderController = TextEditingController();
  var fatPercentageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
    listener: (context, state) {
      if(state is GymCreateUserSuccessState){
        Fluttertoast.showToast(
          msg: 'successfully registered',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          timeInSecForIosWeb: 2,
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
      if(state is GymCreateUserErrorState){
        Fluttertoast.showToast(
          msg: state.error,
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }

    },
    builder: (context, state) {
      var profileImage = GymCubit.get(context).profileImage;
      GymCubit cubit = GymCubit.get(context);
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/abdominal muscles.png'),
              fit: BoxFit.fill, opacity: 150.0),
        ),
        child: Scaffold(
          appBar: AppBar(),
          body: Form(
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

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: ColorsManager.primary,),
                        ),
                        child: CircleAvatar(
                          radius: 65.0,
                          backgroundColor:ColorsManager.primary,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: ColorsManager.black,
                            child:profileImage==null?IconButton(onPressed: ()
                            {
                              GymCubit.get(context).getProfileImage();
                            },
                                color: ColorsManager.primary,
                                icon:const Icon(IconlyBroken.camera,size:50.0,),
                            ) :Image(image:FileImage(profileImage)),
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
                      isPassword: false,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppString.thisFiledFree;
                        }
                        return null;
                      },
                      controller: heightController,
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
                      isPassword: false,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppString.thisFiledFree;
                        }
                        return null;
                      },
                      controller: weightController,
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
                      isPassword: false,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppString.thisFiledFree;
                        }
                        return null;
                      },
                      controller:ageController,
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
                      isPassword: false,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppString.thisFiledFree;
                        }
                        return null;
                      },
                      controller: fatPercentageController,
                      textInputType: TextInputType.name,
                      icon: IconlyBroken.message,
                      hintText: 'Enter your ${AppString.fatPercentage}',
                    ),
                    Text(
                      AppString.gender,
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
                      controller:genderController,
                      textInputType: TextInputType.text,
                      icon: IconlyBroken.message,
                      hintText: 'Enter your ${AppString.gender}',
                    ),
                    const SizedBox(height: 30.0,),

                    MaterialButton(
                      height: 54,
                      minWidth: double.infinity,
                      shape: const StadiumBorder(),
                      color: ColorsManager.primary,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                              if(profileImage!=null){
                              cubit.uploadProfileImage()
                                  .then((value) {
                              cubit.userRegister(
                              email:email,
                              password: password,
                              name:name,
                              weight:weightController.text ,
                              fatPercentage:fatPercentageController.text ,
                              age: ageController.text,
                              height:heightController.text ,
                              phone: phone,
                              gender:genderController.text ,
                              );
                              })
                                  .catchError((error){

                              });

                              }
                              else{
                                cubit.userRegister(
                                  email:email,
                                  password: password,
                                  name:name,
                                  weight:weightController.text ,
                                  fatPercentage:fatPercentageController.text ,
                                  age: ageController.text,
                                  height:heightController.text ,
                                  phone: phone,
                                  gender:genderController.text ,
                                );

                              }
                        }
                      },
                      child: const Text('Finish',
                          style: TextStyle(
                            inherit: false,
                            color: Colors.black,
                            fontSize: 20.0,
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
    });
  }
}
