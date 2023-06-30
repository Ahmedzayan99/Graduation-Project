
// ignore_for_file: prefer_typing_uninitialized_variables, file_names, unnecessary_null_comparison, prefer_const_constructors
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
import '../../shared/widgets/custom_text_form_filed.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
    const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
    var confirmController = TextEditingController();
    var passController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    @override
  Widget build(BuildContext context) {
      return BlocConsumer<GymCubit,GymStates>(
     listener: (context, state) {
       if(state is GetUserSuccessState){
         Fluttertoast.showToast(
           msg:"${'doneSuccessfully'.tr(context)}",
           backgroundColor: Colors.green,
           textColor: Colors.black,
         );
       }
       if(state is UserUpdateErrorState){
         Fluttertoast.showToast(
           msg:"An Update problem",
           backgroundColor: Colors.red,
           textColor: Colors.black,
         );
       }
       if(state is UpdateUserPasswordErrorState){
         Fluttertoast.showToast(
           msg:"An Update problem",
           backgroundColor: Colors.red,
           textColor: Colors.black,
         );
       }
     },
      builder: (context, state) {
        var userModel = GymCubit.get(context).userModel;
       var profileImage = GymCubit.get(context).profileImage;
       var profileImage1;
       if (profileImage==null){
         profileImage1 = NetworkImage('${userModel?.users!.imageUrl}');
       }
       else{
         profileImage1 = FileImage(profileImage);
       }
       return Scaffold(
         appBar: AppBar(),
         body: SingleChildScrollView(
           physics: const BouncingScrollPhysics(),
           child: Padding(
               padding:   const EdgeInsets.all(10.0),
               child: Column(
                 children:  [
                   SizedBox(
                     height: 210.0,
                     width: double.infinity,
                     child: Stack(
                       alignment: AlignmentDirectional.bottomCenter,
                       children: [
                          Align(
                           alignment: AlignmentDirectional.topStart,
                           child: Container(
                               clipBehavior: Clip.antiAliasWithSaveLayer,
                             decoration: BoxDecoration(

                                 borderRadius: const BorderRadius.only(topRight:  Radius.circular(10.0),topLeft: Radius.circular(10.0))
                             ),
                               height: 160.0,
                               width: double.infinity,
                               child: const Image(
                                 image:AssetImage(
                                     'assets/images/gym.jpg'),fit:BoxFit.cover,)),
                         ),
                         CircleAvatar(
                           radius: 65.0,
                           backgroundColor:ColorsManager.primary,
                             child: Stack(
                               alignment: AlignmentDirectional.bottomEnd,
                               children: [
                                 CircleAvatar(
                                   backgroundImage:profileImage1,
                                   radius: 62.0,
                                 ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                             radius: 20.0,
                             child: IconButton(onPressed: ()
                             {
                               GymCubit.get(context).getProfileImage();
                             },
                                 color: ColorsManager.primary,
                                 icon: const Icon(Icons.photo_camera,)) ,
                           ) ],
                             ),
                         ),
                       ],

                     ),

                   ),
                   const SizedBox(height: 20.0,),
                   if(GymCubit.get(context).profileImage != null)
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 15.0),
                           child: Row(children: [
                               Expanded(
                                 child: ConditionalBuilder(
                                   condition:state is!UploadProfileImageLoadingState,
                                   fallback: (context) => defaultProgressIndicator(),
                                   builder:(context) =>
                                       MaterialButton(
                                         height: 54,
                                         minWidth: double.maxFinite,
                                         clipBehavior: Clip.antiAliasWithSaveLayer,
                                         shape: const StadiumBorder(),
                                         color: ColorsManager.primary,
                                         onPressed: () {
                                           GymCubit.get(context).uploadProfileImage();

                                         },
                                         child:   Text("${'upDate'.tr(context)}",
                                             style: const TextStyle(
                                               inherit: false,
                                               color: Colors.black,
                                               fontSize: 20.0,
                                               fontWeight: FontWeight.bold,
                                             )),
                                       ),
                                 ),
                               ),
                   ],),
                         ),
                   const SizedBox(height: 20.0,),
                   Form(
                     key: _formKey,
                     child: Container(
                       clipBehavior: Clip.antiAliasWithSaveLayer,
                       decoration: BoxDecoration(
                           border: Border.all(
                             width: 2.0,
                             color: ColorsManager.primary,
                           ),
                       borderRadius: BorderRadius.all(Radius.circular(10.0))),
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   Text('Change the Password',
                                     textAlign:TextAlign.start,
                                     style: TextStyle(
                                       color: Colors.red,
                                       fontSize: 18.0,
                                       fontWeight: FontWeight.bold
                                     ),
                                   ),
                                   SizedBox(width: 3.0,),
                                   Icon(Icons.password_outlined,color: ColorsManager.primary,)
                                 ],
                               ),
                               const SizedBox(
                                 height: 20.0,),
                               Text(' New Password',
                                 style: TextStyle(
                                   inherit: false,
                                   color: ColorsManager.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.w700,
                                 ),),
                               CustomTextFormFiled(
                                 validator: (p0) {
                                   if (p0!.isEmpty) {
                                     return "${'thisFieldRequired'.tr(context)}";

                                   }
                                   return null;
                                 },
                                 controller: passController,
                                 textInputType: TextInputType.visiblePassword,
                                 icon:const Icon(IconlyBroken.lock,),
                                 isPassword:GymCubit.get(context).isPasswordLogin,
                                 hintText:"New password",
                                 suffixIcon: GymCubit.get(context).iconPasswordLogin,
                                 suffixOnPressed: (){
                                   GymCubit.get(context).changePasswordLoginVisible();
                                 },
                               ),
                               const SizedBox(
                                 height: 20.0,),
                               Text(' Confirm Password',
                                 style: TextStyle(
                                   inherit: false,
                                   color: ColorsManager.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.w700,
                                 ),),
                               CustomTextFormFiled(
                                 validator: (p0) {
                                   if (p0!.isEmpty) {
                                      return "${'thisFieldRequired'.tr(context)}";
                                    }
                                   else if(p0! != passController.text){
                                     return 'ddddddd';
                                   }
                                   return null;
                                 },
                                 controller: confirmController,
                                 textInputType: TextInputType.visiblePassword,
                                 icon:const Icon(IconlyBroken.lock,),
                                 isPassword:GymCubit.get(context).isPasswordConfirmLogin,
                                 hintText:"Confirm password",
                                 suffixIcon: GymCubit.get(context).iconPasswordConfirmLogin,
                                 suffixOnPressed: (){
                                   GymCubit.get(context).changePasswordConfirmVisible();
                                 },
                               ),
                              /* const SizedBox(height: 15.0,),
                               Text(
                                 "${'phoneNumber'.tr(context)}",
                                 style: TextStyle(
                                   inherit: false,
                                   color: ColorsManager.white,
                                   fontSize: 18,
                                   fontWeight: FontWeight.w700,
                                 ),),
                               CustomTextFormFiled(
                                 controller: phoneController,
                                 isPassword: false,
                                 hintText:'${userModel?.phone}',
                                 textInputType: TextInputType.phone,
                                 icon: Icon(IconlyBroken.message),
                               ),
                               const SizedBox(height: 15.0,),*/
                               const  SizedBox(height: 29.0,),
                               ConditionalBuilder(
                                 condition:state is!UpdateUserPasswordLoadingState,
                                 fallback: (context) => defaultProgressIndicator(),
                                 builder:(context) => MaterialButton(
                                   height: 54,
                                   minWidth: double.infinity,
                                   shape: const StadiumBorder(),
                                   color: ColorsManager.primary,
                                   onPressed: () {
                                     if(_formKey.currentState!.validate())
                                     {GymCubit.get(context).updateProfilePassword(password: passController.text);
                                       //  cubit.userLogin(
                                       //  email: userNameController.text,
                                       //password: passController.text,
                                       // );

                                     }
                                    // GymCubit.get(context).updateName(name: nameController.text);
                                   },
                                   child:   Text("${'upDate'.tr(context)}",
                                       style: const TextStyle(
                                         inherit: false,
                                         color: Colors.black,
                                         fontSize: 20.0,
                                         fontWeight: FontWeight.bold,
                                       )),
                                 ),
                               ),

                             ]),
                       ),

                     ),
                   ),
               /*    Container(
                     height: 900.0,
                     decoration: BoxDecoration(
                         border: Border.all(
                           width: 2.0,
                           color: ColorsManager.primary,
                         )),
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Column(
                           children: [
                             Text('about body',
                               style: TextStyle(
                                 color: ColorsManager.white,
                                 fontSize: 18.0,
                               ),
                             ),
                             const SizedBox(
                               height: 30.0,),
                             CustomDefaultSlider(
                               textOfTitle:"${'height'.tr(context)}",
                               showValue: '${GymCubit.get(context).heightInitial.round()}',
                               textAlphabetic: "${'cm'.tr(context)}",
                               value:GymCubit.get(context).heightInitial ,
                               min: 0,
                               max: 240,
                               onChanged:(value) {
                                 GymCubit.get(context).updateHeight(height: value);
                               },
                             ),
                             const SizedBox(
                               height: 30.0,),
                             CustomDefaultSlider(
                               textOfTitle:"${'weight'.tr(context)}",
                               showValue: '${GymCubit.get(context).weightInitial.round()}',
                               textAlphabetic: "${'kg'.tr(context)}",
                               value:GymCubit.get(context).weightInitial ,
                               min: 0,
                               max: 240,
                               onChanged:(value) {
                                 GymCubit.get(context).updateWeight(weight: value);
                               },
                             ),
                             const SizedBox(
                               height: 30.0,),
                             CustomDefaultSlider(
                               textOfTitle:"${'age'.tr(context)}",
                               showValue: '${GymCubit.get(context).ageInitial.round()}',
                               textAlphabetic:"${'yearOld'.tr(context)}",
                               value:GymCubit.get(context).ageInitial ,
                               min: 0,
                               max: 240,
                               onChanged:(value) {
                                 GymCubit.get(context).updateAge(age: value);
                               },
                             ),
                             const SizedBox(
                               height: 30.0,),
                             CustomDefaultSlider(
                               textOfTitle:"${'fatPercentage'.tr(context)}",
                               showValue: '${GymCubit.get(context).fatPercentageInitial.round()}',
                               textAlphabetic: '%',
                               value:GymCubit.get(context).fatPercentageInitial ,
                               min: 0,
                               max: 240,
                               onChanged:(value) {
                                 GymCubit.get(context).updateFatPercentaget(fatPercentage: value);
                               },
                             ),
                             const SizedBox(
                               height: 30.0,),
                             ConditionalBuilder(
                               condition:state is!UpdateUserBadyLoadingState,
                               fallback: (context) => defaultProgressIndicator(),
                               builder:(context) =>    MaterialButton(
                                 height: 54,
                                 minWidth: double.infinity,
                                 shape: const StadiumBorder(),
                                 color: ColorsManager.primary,
                                 onPressed: () {
                             //      GymCubit.get(context).updateUserBady();
                                 },
                                 child:   Text("${'upDate'.tr(context)}",
                                     style: TextStyle(
                                       inherit: false,
                                       color: Colors.black,
                                       fontSize: 20.0,
                                       fontWeight: FontWeight.bold,
                                     )),
                               ),
                             ),

                           ]),
                     ),
                   ),*/
                 ],
               ),
             ),
         ),
       );
      },
    );
  }
}
/* Text(
                     AppString.phoneNumber,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: phoneController,
                     isPassword: false,
                     hintText:'${userModel?.phone}',
                     textInputType: TextInputType.phone,

                   ),
                   const SizedBox(height: 20.0,),
                   Text(
                     AppString.height,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: heightController,
                     isPassword: false,
                     hintText:'${userModel?.height}',
                     textInputType: TextInputType.number,
                   ),
                   const SizedBox(height: 20.0,),
                   Text(
                     AppString.age,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: ageController,
                     isPassword: false,
                     hintText:'${userModel?.age}',
                     textInputType: TextInputType.number,
                   ),
                   const SizedBox(height: 20.0,),
                   Text(
                     AppString.weight,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: weightController,
                     isPassword: false,
                     hintText:'${userModel?.weight}',
                     textInputType: TextInputType.name,
                   ),
                   const SizedBox(height: 20.0,),
                   Text(
                     AppString.height,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: heightController,
                     isPassword: false,
                     validator: (value) {
                       if (value!.isEmpty) {
                         return AppString.thisFiledFree;
                       }
                       return null;
                     },
                     hintText:'${userModel?.height}',
                     textInputType: TextInputType.number,
                   ),
                   const SizedBox(height: 20.0,),
                   Text(
                     AppString.gender,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: genderController,
                     isPassword: false,
                     hintText:'${userModel?.gender}',
                     textInputType: TextInputType.name,
                   ),
                   const SizedBox(height: 20.0,),

 */
