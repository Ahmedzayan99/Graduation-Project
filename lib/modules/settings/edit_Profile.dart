
// ignore_for_file: prefer_typing_uninitialized_variables, file_names, unnecessary_null_comparison

import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/styles/colors_manager.dart';
import '../shared/styles/iconly_broken.dart';
import '../shared/styles/string_manager.dart';
import '../shared/widgets/custom_text_form_filed.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
    EditProfileScreen({Key? key}) : super(key: key);
    var nameController = TextEditingController();
    var passController = TextEditingController();
    var userNameController =TextEditingController();
    var heightController = TextEditingController();
    var weightController = TextEditingController();
    var ageController = TextEditingController();
    var fatPercentageController = TextEditingController();
    var phoneController = TextEditingController();
    var genderController = TextEditingController();

    @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
     listener: (context, state) {
       if(state is GymGetUserSuccessState){
         Fluttertoast.showToast(
           msg: 'successfully Updata ',
           backgroundColor: Colors.white,
           textColor: Colors.black,
         );
         Navigator.pop(context);
       }
     },
      builder: (context, state) {
       var userModel = GymCubit.get(context).userModel!;
       var profileImage = GymCubit.get(context).profileImage;
       var profileImage1;
       if (profileImage==null){
         profileImage1 = NetworkImage('${userModel.image}');
       }
       else{
         profileImage1 = FileImage(profileImage);
       }
       return Scaffold(
         appBar: AppBar(
             actions: [
               TextButton(onPressed: () {
                 if (profileImage!= null) {
                      GymCubit.get(context).uploadProfileImage()
                          .then((value) {
                        GymCubit.get(context).updateUser(
                          uId: userModel.uId.toString(),
                          height: heightController.text.isEmpty
                              ? userModel.height
                              : heightController.text,
                          name: nameController.text.isEmpty
                              ? userModel.name
                              : nameController.text,
                          email: userNameController.text.isEmpty
                              ? userModel.email
                              : userNameController.text,
                          age: ageController.text.isEmpty
                              ? userModel.age
                              : ageController.text,
                          fatPercentage: fatPercentageController.text.isEmpty
                              ? userModel.fatPercentage
                              : fatPercentageController.text,
                          weight: userNameController.text.isEmpty ? userModel
                              .weight : userNameController.text,
                          phone: phoneController.text.isEmpty
                              ? userModel.phone
                              : phoneController.text,
                          gender: genderController.text.isEmpty
                              ? userModel.gender
                              : genderController.text,
                        );
                      });
                      }
                   else{
                   GymCubit.get(context).updateUser(
                     image: profileImage1,
                     uId: userModel.uId.toString(),
                 height: heightController.text.isEmpty
                 ? userModel.height
                     : heightController.text,
                 name: nameController.text.isEmpty
                 ? userModel.name
                     : nameController.text,
                 email: userNameController.text.isEmpty
                 ? userModel.email
                     : userNameController.text,
                 age: ageController.text.isEmpty
                 ? userModel.age
                     : ageController.text,
                 fatPercentage: fatPercentageController.text.isEmpty
                 ? userModel.fatPercentage
                     : fatPercentageController.text,
                 weight: userNameController.text.isEmpty
                 ? userModel.weight
                     : userNameController.text,
                 phone: phoneController.text.isEmpty
                 ? userModel.phone
                     : phoneController.text,
                 gender: genderController.text.isEmpty
                 ? userModel.gender
                     : genderController.text,);
                      }
                 },
                      child: const Text('UPDATE',style: TextStyle(color: Colors.orange),),
      ),
      ]),
         body: SingleChildScrollView(
           physics: const BouncingScrollPhysics(),
           child: Padding(
               padding:   const EdgeInsets.all(8.0),
               child: Column(
                 children:  [
                   SizedBox(
                     height: 210.0,
                     width: double.infinity,
                     child: Stack(
                       alignment: AlignmentDirectional.bottomCenter,
                       children: [
                         const Align(
                           alignment: AlignmentDirectional.topStart,
                           child: SizedBox(
                               height: 160.0,
                               width: double.infinity,
                               child: Image(
                                 image:NetworkImage("https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1675796011~exp=1675796611~hmac=7437f86970844e63b2fd176ed671bf9f8f93c25d6d945e20a871b4ef0206af1d"),fit:BoxFit.cover,)),
                         ),
                         CircleAvatar(
                           radius: 65.0,
                           backgroundColor:ColorsManager.primary,
                             child: CircleAvatar(
                               backgroundImage:profileImage1,
                               radius: 62.0,
                               child: Padding(
                                 padding: const EdgeInsets.only(top:45,right: 26.5),
                                   child: IconButton(onPressed: ()
                                   {
                                     GymCubit.get(context).getProfileImage();
                                     },
                                       color: ColorsManager.primary,
                                       icon: const Icon(Icons.photo_camera,size:60.0,)),
                               ) ,
                             ),
                         ),
                       ],

                     ),

                   ),
                   const SizedBox(height: 20.0,),
                   Text(
                     AppString.name,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: nameController,
                     isPassword: false,
                     hintText:'${userModel.name}',
                     textInputType: TextInputType.name,
                     icon: IconlyBroken.message,
                   ),
                   const SizedBox(height: 20.0,),
                   Text(
                     AppString.userName,
                     style: TextStyle(
                       inherit: false,
                       color: ColorsManager.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                     ),),
                   CustomTextFormFiled(
                     controller: userNameController,
                     isPassword: false,
                     hintText:'${userModel.email}',
                     textInputType: TextInputType.emailAddress,
                     icon: IconlyBroken.message,
                   ),
                   const SizedBox(height: 20.0,),
                   Text(
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
                     hintText:'${userModel.phone}',
                     textInputType: TextInputType.phone,
                     icon: IconlyBroken.message,
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
                     hintText:'${userModel.height}',
                     textInputType: TextInputType.number,
                     icon: IconlyBroken.message,
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
                     hintText:'${userModel.age}',
                     textInputType: TextInputType.number,
                     icon: IconlyBroken.message,
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
                     hintText:'${userModel.weight}',
                     textInputType: TextInputType.name,
                     icon: IconlyBroken.message,
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
                     hintText:'${userModel.height}',
                     textInputType: TextInputType.number,
                     icon: IconlyBroken.message,
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
                     hintText:'${userModel.gender}',
                     textInputType: TextInputType.name,
                     icon: IconlyBroken.message,
                   ),
                   const SizedBox(height: 20.0,),


                 ],
               ),
             ),
         ),
       );
      },
    );
  }
}
