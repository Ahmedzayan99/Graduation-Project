// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:blackgym/layout/gym.dart';
import 'package:blackgym/modules/login_register/login/login.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/iconly_broken.dart';
import '../../../shared/styles/string_manager.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_states.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
    listener: (context, state) {
      if(state is LoginSuccessState){
        Fluttertoast.showToast(
          msg: 'successfully registered',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          timeInSecForIosWeb: 2,
        );
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>  LoginScreen(),), (route) => false);

      }

      if(state is CreateUserErrorState){
        Fluttertoast.showToast(
          msg: state.error,
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }

    },
    builder: (context, state) {
    //  var profileImage = AuthCubit.get(context).profileImage;
      AuthCubit cubit = AuthCubit.get(context);
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 30.0,),
                  Container(
                    height: 125.0,
                    width:  double.infinity,
                    decoration: BoxDecoration(color: ColorsManager.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(15.0,))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.height,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                              fontSize: 20.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline:TextBaseline.alphabetic,
                          children: [
                            Text('${cubit.heightInitial.round()}',
                              style:  TextStyle(
                                  color:  ColorsManager.primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0),),
                            const SizedBox(width:3.0,),
                            Text('cm',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.primary,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                        Slider(activeColor: ColorsManager.primary,
                          thumbColor:ColorsManager.primary,
                          value:cubit.heightInitial,
                          min: 80,
                          max: 240,
                          onChanged:(value) {
                            cubit.changeHeight(height:value);
                          },),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,),
                  Container(height: 125.0,
                    width:  double.infinity,
                    decoration: BoxDecoration(color: ColorsManager.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(15.0,))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.weight,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                              fontSize: 20.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline:TextBaseline.alphabetic,
                          children: [
                            Text('${cubit.weightInitial.round()}',
                              style:  TextStyle(
                                  color:  ColorsManager.primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0),),
                            const SizedBox(width:3.0,),
                            Text('kg',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.primary,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                        Slider(activeColor: ColorsManager.primary,
                          thumbColor:ColorsManager.primary,
                          value:cubit.weightInitial,
                          min: 40,
                          max: 200,
                          onChanged:(value) {
                            cubit.changeWeight(weight: value);
                          },),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  Container(height: 125.0,
                    width:  double.infinity,
                    decoration: BoxDecoration(color: ColorsManager.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(15.0,))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.age,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                              fontSize: 20.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline:TextBaseline.alphabetic,
                          children: [
                            Text('${cubit.ageInitial.round()}',
                              style:  TextStyle(
                                  color:  ColorsManager.primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0),),
                            const SizedBox(width:3.0,),
                            Text('year old',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.primary,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                        Slider(activeColor: ColorsManager.primary,
                          thumbColor:ColorsManager.primary,
                          value:cubit.ageInitial,
                          min:12,
                          max: 100,
                          onChanged:(value) {
                            cubit.changeAge(age:value);
                          },),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  Container(height: 125.0,
                    width:  double.infinity,
                    decoration: BoxDecoration(color: ColorsManager.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(15.0,))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.fatPercentage,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                              fontSize: 20.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline:TextBaseline.alphabetic,
                          children: [
                            Text('${cubit.fatPercentageInitial.round()}',
                              style:  TextStyle(
                                  color:  ColorsManager.primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0),),
                            const SizedBox(width:3.0,),
                            Text('%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.primary,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                        Slider(activeColor: ColorsManager.primary,
                          thumbColor:ColorsManager.primary,
                          value:cubit.fatPercentageInitial,
                          min: 1,
                          max: 100,
                          onChanged:(value) {
                            cubit.changefatPercentaget(fatPercentage:value);
                          },),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cubit.changeGender(gender:true
                              );

                            },
                            child: Container(
                              height: 60.0,
                              alignment: AlignmentDirectional.center ,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0,),
                                color:cubit.genderInitial? ColorsManager.primary : ColorsManager.grey,),
                              child:const Text('MALE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Colors.white),),
                            ),
                          ),

                      ),
                      const SizedBox(width: 5.0,),
                      Expanded(
                          child: GestureDetector(
                            onTap:(){
                              cubit.changeGender(gender: false);
                            } ,
                            child: Container(
                              height: 60.0,
                              alignment: AlignmentDirectional.center ,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0,),
                                color:cubit.genderInitial? ColorsManager.grey :ColorsManager.primary ,
                              ),
                              child:const Text('FEMALE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Colors.white),),
                            ),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0,),
                  MaterialButton(
                    height: 54,
                    minWidth: double.infinity,
                    shape: const StadiumBorder(),
                    color: ColorsManager.primary,
                    onPressed: () {
                              cubit.userRegister(
                                email:email,
                                password: password,
                                name:name,
                                phone: phone,
                              );
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
      );
    });
  }
}
/**      Align(
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
    child://profileImage==null?
    IconButton(onPressed: ()
    {
    //AuthCubit.get(context).getProfileImage();
    },
    color: ColorsManager.primary,
    icon:const Icon(IconlyBroken.camera,size:50.0,),
    ) //:Image(image:FileImage(profileImage)),
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
 **/
