// ignore_for_file: must_be_immutable, unnecessary_null_comparison, unnecessary_import

import 'package:blackgym/modules/gym.dart';
import 'package:blackgym/modules/login_register/cubit/authentication_cubit.dart';
import 'package:blackgym/modules/login_register/cubit/authentication_states.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/widgets/custom_defaultSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      if(state is RegisterLoadingState) {
        Center(child: defaultProgressIndicator());
      }
        if(state is LoginSuccessState){
        GymCubit.get(context).current =0;
        Fluttertoast.showToast(
          msg: "${'doneSuccessfully'.tr(context)}",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          timeInSecForIosWeb: 2,
        );
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) =>  NewLayout(),), (route) => false);
      }
      if(state is RegisterErrorState){
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
                  CustomDefaultSlider(
                    textOfTitle:"${'height'.tr(context)}",
                    showValue: '${cubit.heightInitial.round()}',
                    textAlphabetic: "${'cm'.tr(context)}",
                    value:cubit.heightInitial,
                    min: 80,
                    max: 240,
                    onChanged:(value) {
                      cubit.changeHeight(height:value);

                    },
                  ),
                  const SizedBox(
                    height: 30.0,),
                  CustomDefaultSlider(
                    textOfTitle:"${'weight'.tr(context)}",
                    showValue: '${cubit.weightInitial.round()}',
                    textAlphabetic: "${'kg'.tr(context)}",
                    value:cubit.weightInitial,
                    min: 40,
                    max: 200,
                    onChanged:(value) {
                      cubit.changeWeight(weight:value);

                    },
                  ),
                  const SizedBox(height: 30.0,),
                  CustomDefaultSlider(
                    textOfTitle:"${'age'.tr(context)}",
                    showValue: '${cubit.ageInitial.round()}',
                    textAlphabetic: "${'yearOld'.tr(context)}",
                    value:cubit.ageInitial,
                    min: 12,
                    max: 100,
                    onChanged:(value) {
                      cubit.changeAge(age:value);

                    },
                  ),
                  const SizedBox(height: 30.0,),
                  CustomDefaultSlider(
                    textOfTitle: "${'fatPercentage'.tr(context)}",
                    showValue: '${cubit.fatPercentageInitial.round()}',
                    textAlphabetic: '%',
                    value:cubit.fatPercentageInitial,
                    min: 1,
                    max: 80,
                    onChanged:(value) {
                      cubit.changefatPercentaget(fatPercentage:value);

                    },
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
                              child: Text("${'male'.tr(context)}",
                                style: const TextStyle(
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
                              child: Text("${'female'.tr(context)}",
                                style: const TextStyle(
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
                   /*   cubit.userRegister(
                        email: email,
                        password: password,
                        name: name,
                        phone: phone,
                      );*/
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) =>  NewLayout(),), (route) => false);
                    },
                    child:  Text("${'finish'.tr(context)}",
                        style: const TextStyle(
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
