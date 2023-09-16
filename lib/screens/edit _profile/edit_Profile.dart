
// ignore_for_file: prefer_typing_uninitialized_variables, file_names, unnecessary_null_comparison, prefer_const_constructors
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubit/settings/settings_cubit.dart';
import '../../cubit/settings/settings_states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
    const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

    @override
  Widget build(BuildContext context) {
      return BlocConsumer<SettingsCubit,SettingsStates>(
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
        var userModel = SettingsCubit.get(context).userModel;
       var profileImage = SettingsCubit.get(context).profileImage;
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
                               SettingsCubit.get(context).getProfileImage();
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
                   if(SettingsCubit.get(context).profileImage != null)
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
                                           SettingsCubit.get(context).uploadProfileImage();

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
                     key: SettingsCubit.get(context).formKey,
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
                                 controller: SettingsCubit.get(context).passController,
                                 textInputType: TextInputType.visiblePassword,
                                 icon:const Icon(IconlyBroken.lock,),
                                 isPassword:SettingsCubit.get(context).isPasswordLogin,
                                 hintText:"New password",
                                 suffixIcon: SettingsCubit.get(context).iconPasswordLogin,
                                 suffixOnPressed: (){
                                   SettingsCubit.get(context).changePasswordLoginVisible();
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
                                   else if(p0! != SettingsCubit.get(context).passController.text){
                                     return 'ddddddd';
                                   }
                                   return null;
                                 },
                                 controller: SettingsCubit.get(context).confirmController,
                                 textInputType: TextInputType.visiblePassword,
                                 icon:const Icon(IconlyBroken.lock,),
                                 isPassword:SettingsCubit.get(context).isPasswordConfirmLogin,
                                 hintText:"Confirm password",
                                 suffixIcon: SettingsCubit.get(context).iconPasswordConfirmLogin,
                                 suffixOnPressed: (){
                                   SettingsCubit.get(context).changePasswordConfirmVisible();
                                 },
                               ),
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
                                     if(SettingsCubit.get(context).formKey.currentState!.validate())
                                     {SettingsCubit.get(context).updateProfilePassword();

                                     }
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
                 ],
               ),
             ),
         ),
       );
      },
    );
  }
}