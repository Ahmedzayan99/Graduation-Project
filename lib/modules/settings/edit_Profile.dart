
// ignore_for_file: prefer_typing_uninitialized_variables, file_names, unnecessary_null_comparison, prefer_const_constructors
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/widgets/custom_defaultSlider.dart';
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
    var nameController = TextEditingController();
    var passController = TextEditingController();

    @override
  Widget build(BuildContext context) {
      return BlocConsumer<GymCubit,GymStates>(
     listener: (context, state) {
       if(state is GetUserSuccessState){
         Fluttertoast.showToast(
           msg:"${'doneSuccessfully'.tr(context)}",
           backgroundColor: Colors.white,
           textColor: Colors.black,
         );
       }
     },
      builder: (context, state) {
        var userModel = GymCubit.get(context).userModel;
       var profileImage = GymCubit.get(context).profileImage;
       var profileImage1;
       if (profileImage==null){
         profileImage1 = NetworkImage('${userModel?.image}');
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
                                   backgroundImage:profileImage1 ?? const NetworkImage("https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1675796011~exp=1675796611~hmac=7437f86970844e63b2fd176ed671bf9f8f93c25d6d945e20a871b4ef0206af1d"),
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
                   Container(
                     height: 280,
                     decoration: BoxDecoration(
                         border: Border.all(
                           width: 2.0,
                           color: ColorsManager.primary,
                         )),
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Column(
                           children: [
                             Text('About profile',
                               textAlign:TextAlign.center,
                               style: TextStyle(
                                 color: ColorsManager.white,
                                 fontSize: 18.0,
                               ),
                             ),
                             const SizedBox(
                               height: 20.0,),
                             Text(
                               "${'name'.tr(context)}",
                               style: TextStyle(
                                 inherit: false,
                                 color: ColorsManager.white,
                                 fontSize: 18,
                                 fontWeight: FontWeight.w700,
                               ),),
                             CustomTextFormFiled(
                               controller: nameController,
                               isPassword: false,
                               hintText:'${userModel?.name}',
                               textInputType: TextInputType.name,
                               icon: const Icon(IconlyBroken.message),
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
                               condition:state is!UpdateNameLoadingState,
                               fallback: (context) => defaultProgressIndicator(),
                               builder:(context) => MaterialButton(
                                 height: 54,
                                 minWidth: double.infinity,
                                 shape: const StadiumBorder(),
                                 color: ColorsManager.primary,
                                 onPressed: () {
                                   GymCubit.get(context).updateName(name: nameController.text);
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
                   const SizedBox(height: 40.0,),
                   Container(
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
                                   GymCubit.get(context).updateUserBady();
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
