import 'package:blackgym/modules/changeLanuage.dart';
import 'package:blackgym/modules/login_register/cubit/authentication_cubit.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'edit_Profile.dart';
import '../login_register/homeSignup.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit, GymStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AuthCubit.get(context).userModel;
          GymCubit cubit = GymCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetUserLoadingState,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                  top: 80,
                  bottom: 20,
                ),
                child: Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: ColorsManager.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
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
                                    child: Icon(
                                      IconlyBroken.profile,
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "${'myProfile'.tr(context)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsManager.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        cubit.myProfile
                                            ? Icon(
                                                Icons.expand_more,
                                                color: ColorsManager.white,
                                              )
                                            : Icon(
                                                Icons.navigate_next,
                                                color: ColorsManager.white,
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (cubit.myProfile)
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: ColorsManager.grey,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(top:0,start:0,end:0,bottom: 15.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                      height: 210.0,
                                      child: Stack(
                                        alignment: AlignmentDirectional
                                            .bottomCenter,
                                        children: [
                                          const Align(
                                            alignment:
                                            AlignmentDirectional
                                                .topStart,
                                            child: SizedBox(
                                                height: 160.0,
                                                width: double.infinity,
                                                //   width: double.infinity,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/gym.jpg'),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          CircleAvatar(
                                            radius: 55.0,
                                            backgroundColor:
                                            ColorsManager.primary,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${userModel?.image}'),
                                              radius: 50.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '${userModel?.name}',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(
                                              251, 251, 251, 1),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [

                                          Row(
                                            children: [
                                              Text("${'userName'.tr(context)}",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        251, 251, 251, 1),
                                                    fontSize: 14.0,
                                                    ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  child: Text(
                                                    '${userModel?.email}',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          251, 251, 251, 1),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${'phoneNumber'.tr(context)}",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      251, 251, 251, 1),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  child: Text(
                                                    '${userModel?.phone}',
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      inherit: true,
                                                      color: Color.fromRGBO(
                                                          251, 251, 251, 1),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${'gender'.tr(context)}",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      251, 251, 251, 1),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  child: Text(
                                                    '${userModel?.gender}',
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      inherit: true,
                                                      color: Color.fromRGBO(
                                                          251, 251, 251, 1),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${'age'.tr(context)}",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      251, 251, 251, 1),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  child: Text(
                                                    '${userModel?.age}',
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      inherit: true,
                                                      color: Color.fromRGBO(
                                                          251, 251, 251, 1),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${'weight'.tr(context)}",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      251, 251, 251, 1),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  child: Text(
                                                    '${userModel?.weight}',
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      inherit: true,
                                                      color: Color.fromRGBO(
                                                          251, 251, 251, 1),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${'height'.tr(context)}",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      251, 251, 251, 1),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  child: Text(
                                                    '${userModel?.height}',
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      inherit: true,
                                                      color: Color.fromRGBO(
                                                          251, 251, 251, 1),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                        ],),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            height: 45,
                                            minWidth: 70.0,
                                            shape: const StadiumBorder(),
                                            color: ColorsManager.primary,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EditProfileScreen(),
                                                  ));
                                            },
                                            child:  Text(
                                                "${'editMyProfile'.tr(context)}",
                                                style: const TextStyle(
                                                  inherit: false,
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            const SizedBox(),
                          const SizedBox(height: 15.0),
                          Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: ColorsManager.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: InkWell(
                              onTap: () {
                                cubit.changeBottomLanguage();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Icon(
                                      Icons.language_sharp,
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "${'language'.tr(context)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsManager.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40.0,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        cubit.language
                                            ? Icon(
                                                Icons.expand_more,
                                                color: ColorsManager.white,
                                              )
                                            : Icon(
                                                Icons.navigate_next,
                                                color: ColorsManager.white,
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          cubit.language
                              ? Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                                  color: ColorsManager.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 35.0),
                                    child: DropdownButton(
                                      isExpanded:true ,
                                      dropdownColor: ColorsManager.grey,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      style: const TextStyle(
                                      color: Colors.white,
                              fontWeight: FontWeight.bold,

                            ),
                                      underline: const SizedBox(
                                    width: double.infinity,
                                    height: 1.0,
                            ),
                                      value: cubit.lang,
                                      icon: const Icon(
                                    Icons.keyboard_arrow_down,
                            ),
                                      items:cubit
                                      .dropDownButton
                                      .map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                        child: Text(
                                          items.toUpperCase(),
                                        ),
                                    );
                            }).toList(),
                                      onChanged: (value) {
                                    cubit.changeLanguage(languageCode: value!);
                            },
                          ),
                                  ),
                                ),
                              )
                              : const SizedBox(),
                          const SizedBox(height: 15.0),
                          Container(
                            width: double.infinity,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                color: ColorsManager.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Column(
                              children: [
                                const SizedBox(height: 15.0),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeSignUpScreen(),
                                        ),
                                        (route) => false);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2.0,
                                        ),
                                        child: Icon(
                                          Icons.star_rate_rounded,
                                          color: ColorsManager.primary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        "${'rate'.tr(context)}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: ColorsManager.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeSignUpScreen(),
                                        ),
                                        (route) => false);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2.0,
                                        ),
                                        child: Icon(
                                          Icons.share,
                                          color: ColorsManager.primary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text("${'shareWithFriends'.tr(context)}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: ColorsManager.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeSignUpScreen(),
                                        ),
                                        (route) => false);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2.0,
                                        ),
                                        child: Icon(
                                          Icons.facebook,
                                          color: ColorsManager.primary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        "${'ourFacebook'.tr(context)}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: ColorsManager.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                InkWell(
                                  onTap: () {
                                    cubit.confirmPasswordReset();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2.0,
                                        ),
                                        child: Icon(
                                          Icons.facebook,
                                          color: ColorsManager.primary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        "${'ourInstagram'.tr(context)}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: ColorsManager.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: ColorsManager.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: InkWell(
                              onTap: () {
                                GymCubit.get(context).logOut();
                                CacheHelper.removeUserData(key: 'uId')
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChangeLanguageScreen(),
                                      ),
                                      (route) => false);
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Icon(
                                      Icons.logout,
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "${'logOut'.tr(context)}",
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
                        ],),
                  ),
                ),
              );
            },
            fallback: (context) => defaultProgressIndicator(),
          );
        });
  }
}
