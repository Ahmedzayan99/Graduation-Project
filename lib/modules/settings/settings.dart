

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import '../shared/styles/colors_manager.dart';
import '../shared/styles/iconly_broken.dart';
import '../shared/styles/string_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'edit_Profile.dart';
import 'login/homeSignup.dart';

class SettingsScreen extends StatelessWidget {
  
   const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GymCubit()..getUserData(),
      child: BlocConsumer<GymCubit,GymStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var userModel = GymCubit.get(context).userModel!;
            GymCubit cubit = GymCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(
            right: 25, left: 25, top: 80, bottom: 20,),
          child: Scaffold(
              body:SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                width: double.infinity,
                height: 40.0,
                decoration: BoxDecoration(
                    color: ColorsManager.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                ),
                child: InkWell(
                  onTap: () {
                    cubit.changeBottomProfile();
                  },
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Icon(IconlyBroken.profile,
                        color: ColorsManager.primary,),
                    ),
                    const SizedBox(width: 4.0,),
                     Text('My profile',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 40.0,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          cubit.myProfile?Icon(Icons.expand_more,color: ColorsManager.white,):Icon(Icons.navigate_next,color: ColorsManager.white,),
                        ],
                      ),),

                  ],
                ),
            ),),
                  if (cubit.myProfile) Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      height: 640.0,
                      decoration:  BoxDecoration(
                          color: ColorsManager.grey,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))
                      ),
                     child:ConditionalBuilder(
                        condition:GymCubit.get(context).userModel!.toMap().isNotEmpty,
                        builder:(context) {
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children:  [
                                SizedBox(
                                  height: 210.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomCenter,
                                    children: [
                                      const Align(
                                        alignment: AlignmentDirectional.topStart,
                                        child: SizedBox(
                                            height: 160.0,
                                            width: double.infinity,
                                            //   width: double.infinity,
                                            child: Image(image:NetworkImage("https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1675796011~exp=1675796611~hmac=7437f86970844e63b2fd176ed671bf9f8f93c25d6d945e20a871b4ef0206af1d"),fit:BoxFit.cover,)),
                                      ),
                                      CircleAvatar(
                                        radius: 55.0,
                                        backgroundColor:ColorsManager.primary,
                                        child:CircleAvatar(
                                          backgroundImage:NetworkImage('${userModel.image}'),
                                          radius: 50.0,
                                        ),
                                      ),
                                    ],

                                  ),

                                ),
                                const SizedBox(height: 20.0,),
                                Text('${userModel.name}',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(251, 251, 251, 1),
                                    fontSize: 20.0,
                                  ),),
                                const SizedBox(height: 20.0,),
                                Row(
                                  children: [
                                    Text('${AppString.userName}:',
                                      style: const TextStyle(
                                          color: Color.fromRGBO(251, 251, 251, 1),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${userModel.email}',
                                            style: const TextStyle(
                                              color: Color.fromRGBO(251, 251, 251, 1),
                                              fontSize: 14.0,
                                            ),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0,),
                                Row(
                                  children: [
                                    Text(AppString.phoneNumber,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(251, 251, 251, 1),
                                        fontSize: 14.0,
                                      ),),
                                    const SizedBox(width: 20.0,),
                                    Expanded(
                                      child: Align(

                                        alignment: Alignment.centerRight,
                                        child: Text('${userModel.phone}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            inherit: true,
                                            color: Color.fromRGBO(251, 251, 251, 1),
                                            fontSize: 14.0,
                                          ),),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0,),
                                Row(
                                  children: [
                                    Text(AppString.gender,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(251, 251, 251, 1),
                                        fontSize: 14.0,
                                      ),),

                                    const SizedBox(width: 20.0,),
                                    Expanded(
                                      child: Align(

                                        alignment: Alignment.centerRight,
                                        child: Text('${userModel.gender}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            inherit: true,
                                            color: Color.fromRGBO(251, 251, 251, 1),
                                            fontSize: 14.0,
                                          ),),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0,),
                                Row(
                                  children: [
                                    Text('${AppString.age} :',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(251, 251, 251, 1),
                                        fontSize: 14.0,
                                      ),),
                                    const SizedBox(width: 20.0,),
                                    Expanded(
                                      child: Align(

                                        alignment: Alignment.centerRight,
                                        child: Text('${userModel.age}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            inherit: true,
                                            color: Color.fromRGBO(251, 251, 251, 1),
                                            fontSize: 14.0,
                                          ),),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0,),
                                Row(
                                  children: [
                                    Text('${AppString.weight}:',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(251, 251, 251, 1),
                                        fontSize: 14.0,
                                      ),),
                                    const SizedBox(width: 20.0,),
                                    Expanded(
                                      child: Align(

                                        alignment: Alignment.centerRight,
                                        child: Text('${userModel.weight}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            inherit: true,
                                            color: Color.fromRGBO(251, 251, 251, 1),
                                            fontSize: 14.0,
                                          ),),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0,),
                                Row(
                                  children: [
                                    Text('${AppString.height} :',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(251, 251, 251, 1),
                                        fontSize: 14.0,
                                      ),),
                                    const SizedBox(width: 20.0,),
                                    Expanded(
                                      child: Align(

                                        alignment: Alignment.centerRight,
                                        child: Text('${userModel.height}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            inherit: true,
                                            color: Color.fromRGBO(251, 251, 251, 1),
                                            fontSize: 14.0,
                                          ),),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                      height: 45,
                                      minWidth: 70.0,
                                      shape:  const StadiumBorder(),
                                      color: ColorsManager.primary,
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>  EditProfileScreen(),));
                                      },
                                      child:  const Text('Edit My Profile',
                                          style:TextStyle(
                                            inherit: false,
                                            color:Colors.white,
                                            fontSize:20.0,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),

                                  ],
                                ),


                              ],
                            ),
                          );
                        },
                        fallback:(context) =>Center(child:CircularProgressIndicator( color:ColorsManager.primary,)),
                    ),),)else const SizedBox(),
                   const SizedBox(height: 15.0),
                  Container(
                width: double.infinity,
                height: 40.0,
                decoration:  BoxDecoration(
                    color: ColorsManager.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                ),
                child: InkWell(
                  onTap: () {cubit.changeBottomLanguage();},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child:  Icon(
                          Icons.language_sharp,
                          color: ColorsManager.primary,),
                      ),
                      const SizedBox(width: 4.0,),
                       Text('Language',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ColorsManager.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 40.0,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            cubit.language?Icon(Icons.expand_more,color: ColorsManager.white,):Icon(Icons.navigate_next,color: ColorsManager.white,),

                          ],
                        ),),

                    ],
                  ),
                ),
            ),
                  cubit.language?Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: ColorsManager.grey,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children:  [
                            cubit.selectLanguage?InkWell(
                              onTap: () {
                                cubit.changeBottomSelectLanguage();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0,),
                                    child:   Icon(Icons.language,
                                      color: ColorsManager.primary,),
                                  ),
                                  const SizedBox(width: 4.0,),
                                  Text('EN',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsManager.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ):InkWell(
                              onTap: () {
                                cubit.changeBottomSelectLanguage();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0,),
                                    child:   Icon(Icons.language,
                                      color: ColorsManager.primary,),
                                  ),
                                  const SizedBox(width: 4.0,),
                                  Text('AR',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsManager.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ):const SizedBox(),
                  const SizedBox(height: 15.0),
                  Container(
                width: double.infinity,
                height: 170.0,
                decoration:  BoxDecoration(
                    color: ColorsManager.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                ),
                child: Column(
                  children:  [
                    const SizedBox(height: 15.0),
                     InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(
                              builder: (context) => const HomeSignUpScreen(),), (
                                route) => false);
                      },

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0,),
                            child:   Icon(Icons.star_rate_rounded,
                              color: ColorsManager.primary,),
                          ),
                          const SizedBox(width: 4.0,),
                          Text('Rate the App',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                     InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(
                              builder: (context) => const HomeSignUpScreen(),), (
                                route) => false);
                      },

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0,),
                            child:   Icon(Icons.share,
                              color: ColorsManager.primary,),
                          ),
                          const SizedBox(width: 4.0,),
                          Text('Share with Friends',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                     InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(
                              builder: (context) => const HomeSignUpScreen(),), (
                                route) => false);
                      },

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0,),
                            child:   Icon(Icons.facebook,
                              color: ColorsManager.primary,),
                          ),
                          const SizedBox(width: 4.0,),
                          Text('Our Facebook',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                     InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(
                              builder: (context) => const HomeSignUpScreen(),), (
                                route) => false);
                      },

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0,),
                            child:   Icon(Icons.facebook,
                              color: ColorsManager.primary,),
                          ),
                          const SizedBox(width: 4.0,),
                          Text('Our instagram',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
                  const SizedBox(height: 15.0,),
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration:  BoxDecoration(
                        color: ColorsManager.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: InkWell(
                      onTap: () {
                       GymCubit.get(context).userSignOut();
                       CacheHelper.removeUserData(key: 'uId');
                      },

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child:   Icon(Icons.logout,
                              color: ColorsManager.primary,),
                          ),
                          const SizedBox(width: 4.0,),
                          Text('Log Out',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ]),
              ),
          ),);
      }),
    );
  }
}