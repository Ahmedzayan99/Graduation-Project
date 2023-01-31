

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/styles/colors_manager.dart';
import '../shared/styles/iconly_broken.dart';
import '../shared/styles/string_manager.dart';

import 'login/homeSignup.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
  String image ="assets/images/zay.jpg";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener: (context, state) {},
    builder: (context, state) {
      GymCubit cubit = GymCubit.get(context);
      return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 25, left: 25, top: 20, bottom: 20,),
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
                cubit.myProfile?Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 330.0,
                    decoration:  BoxDecoration(
                        color: ColorsManager.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:  [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(

                                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(50.0),border:Border.all(color: ColorsManager.primary,),
                                  ),
                                  child:  CircleAvatar(
                                    backgroundImage:AssetImage(image),
                                    radius: 50.0,
                                    backgroundColor: ColorsManager.black,
                                    child:image.isEmpty?Icon(
                                      color:ColorsManager.primary,
                                      IconlyBroken.camera,
                                    ):const SizedBox(),
                                  ),
                                ),
                                const Text("Ahmed Zayan",
                                  style: TextStyle(
                                    color: Color.fromRGBO(251, 251, 251, 1),
                                    fontSize: 14.0,
                                  ),),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(AppString.userName,
                                style: const TextStyle(
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  fontSize: 14.0,
                                ),),
                              const SizedBox(width: 20.0,),
                              const Expanded(
                                child: Align(

                                  alignment: Alignment.centerRight,
                                  child: Text('@Ahmed_zayan99',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      inherit: true,
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      fontSize: 14.0,
                                    ),),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(AppString.phoneNumber,
                                style: const TextStyle(
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  fontSize: 14.0,
                                ),),
                              const SizedBox(width: 20.0,),
                              const Expanded(
                                child: Align(

                                  alignment: Alignment.centerRight,
                                  child: Text('01129820937',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      inherit: true,
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      fontSize: 14.0,
                                    ),),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text(AppString.gender,
                                style: const TextStyle(
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  fontSize: 14.0,
                                ),),
                              const SizedBox(width: 20.0,),
                              const Expanded(
                                child: Align(

                                  alignment: Alignment.centerRight,
                                  child: Text('Male',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      inherit: true,
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      fontSize: 14.0,
                                    ),),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text('${AppString.age} :',
                                style: const TextStyle(
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  fontSize: 14.0,
                                ),),
                              const SizedBox(width: 20.0,),
                              const Expanded(
                                child: Align(

                                  alignment: Alignment.centerRight,
                                  child: Text('23',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      inherit: true,
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      fontSize: 14.0,
                                    ),),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text('${AppString.weight} :',
                                style: const TextStyle(
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  fontSize: 14.0,
                                ),),
                              const SizedBox(width: 20.0,),
                              const Expanded(
                                child: Align(

                                  alignment: Alignment.centerRight,
                                  child: Text('68KG',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      inherit: true,
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      fontSize: 14.0,
                                    ),),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text('${AppString.height} :',
                                style: const TextStyle(
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  fontSize: 14.0,
                                ),),
                              const SizedBox(width: 20.0,),
                              const Expanded(
                                child: Align(

                                  alignment: Alignment.centerRight,
                                  child: Text('168cm',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      inherit: true,
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      fontSize: 14.0,
                                    ),),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Change the Password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  inherit: true,
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  fontSize: 18.0,
                                ),),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                     ):const SizedBox(),
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
                          cubit.myProfile?Icon(Icons.expand_more,color: ColorsManager.white,):Icon(Icons.navigate_next,color: ColorsManager.white,),

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
            ]),),
      );
    });
  }
}