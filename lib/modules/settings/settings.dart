
import 'dart:ui';

import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../login_register/homeSignup.dart';
import 'edit_Profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit, GymStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = GymCubit.get(context).userModel;
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
                                                    '${userModel?.users!.imageUrl}'),
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
                                        '${userModel?.users!.name}',
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
                                                      '${userModel?.users!.email}',
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
                                                      '${userModel?.users!.phoneNumber}',
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
                                                      '${userModel?.users!.gender}',
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
                                                      '${userModel?.users!.age}',
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
                                                      '${userModel?.users!.weight}',
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
                                                      '${userModel?.users!.height}',
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
                                                  "${'fatPercentage'.tr(context)}",
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
                                                      '${userModel?.users!.fatPercentage}',
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
                                                  'Coash Name',
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
                                                      '${userModel?.users!.coashName}',
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
                                            Row(children: [
                                              Text(
                                                "Subscription",
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
                                                    '${userModel?.users!.gender}',
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
                                                          EditProfileScreen(),
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
                          // Container(
                          //   width: double.infinity,
                          //   height: 40.0,
                          //   decoration: BoxDecoration(
                          //       color: ColorsManager.grey,
                          //       borderRadius: const BorderRadius.all(
                          //           Radius.circular(10.0))),
                          //   child: InkWell(
                          //     onTap: () {
                          //       cubit.changeBottomLanguage();
                          //     },
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 2.0),
                          //           child: Icon(
                          //             Icons.language_sharp,
                          //             color: ColorsManager.primary,
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           width: 4.0,
                          //         ),
                          //         Text(
                          //           "${'language'.tr(context)}",
                          //           maxLines: 1,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: TextStyle(
                          //             color: ColorsManager.white,
                          //             fontWeight: FontWeight.w700,
                          //             fontSize: 18,
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           width: 40.0,
                          //         ),
                          //         Expanded(
                          //           child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.end,
                          //             children: [
                          //               cubit.language
                          //                   ? Icon(
                          //                       Icons.expand_more,
                          //                       color: ColorsManager.white,
                          //                     )
                          //                   : Icon(
                          //                       Icons.navigate_next,
                          //                       color: ColorsManager.white,
                          //                     ),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // cubit.language
                          //     ? Padding(
                          //       padding: const EdgeInsets.only(top: 15.0),
                          //       child: Container(
                          //   width: double.infinity,
                          //   height: 50.0,
                          //   decoration: BoxDecoration(
                          //         color: ColorsManager.grey,
                          //         borderRadius: const BorderRadius.all(
                          //             Radius.circular(10.0))),
                          //         child: Padding(
                          //           padding: const EdgeInsetsDirectional.only(start: 35.0),
                          //           child: DropdownButton(
                          //             isExpanded:true ,
                          //             dropdownColor: ColorsManager.grey,
                          //             iconEnabledColor: Colors.white,
                          //             iconDisabledColor: Colors.white,
                          //             borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          //             style: const TextStyle(
                          //             color: Colors.white,
                          //     fontWeight: FontWeight.bold,
                          //
                          //   ),
                          //             underline: const SizedBox(
                          //           width: double.infinity,
                          //           height: 1.0,
                          //   ),
                          //             value: cubit.lang,
                          //             icon: const Icon(
                          //           Icons.keyboard_arrow_down,
                          //   ),
                          //             items:cubit
                          //             .dropDownButton
                          //             .map((String items) {
                          //           return DropdownMenuItem(
                          //             value: items,
                          //               child: Text(
                          //                 items.toUpperCase(),
                          //               ),
                          //           );
                          //   }).toList(),
                          //             onChanged: (value) {
                          //           cubit.changeLanguage(languageCode: value!);
                          //   },
                          // ),
                          //         ),
                          //       ),
                          //     )
                          //     : const SizedBox(),
                          Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: ColorsManager.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: InkWell(
                              onTap: () {
                                cubit.changeBottomBranch();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Icon(Icons.place_outlined,
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "Our branches",
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
                          if(cubit.ourBranch)
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 8.0,),
                                          Text("Beni Suef:3New Street, next to Al-Jamal Store, second floor",
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  251, 251, 251, 1),
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                color: ColorsManager.primary,
                                                height: 2.0,
                                                width: 150.0,
                                                alignment: AlignmentDirectional.center,
                                            ),
                                          ),
                                          Text("Shubra El Kheima:5Mohamed Awad Street, off El Nass Street, next to El Mahrousa Café, second floor",
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  251, 251, 251, 1),
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],),
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
                                cubit.changeBottomEvaluateCoach();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Icon(Icons.place_outlined,
                                      color: ColorsManager.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "Rating your coach",
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
                          if(cubit.EvaluateCoach)
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: ColorsManager.grey,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:  CrossAxisAlignment.center,
                                        children: [
                                          RatingBar.builder(
                                            itemBuilder: (BuildContext context, int index) {
                                              return Icon(Icons.star);},
                                            onRatingUpdate: (double value) {  },


                                          )

              ],),
                                    ),

                                  ],
                                ),
                              ),
                            )
                          else
                            const SizedBox(),
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
                                  onTap: () async {
                                    const  url ='https://www.facebook.com/ahmed.zayan99';
                                    if(await canLaunch(url)){
                                    await launch(url);
                                        }
                                    else{
                                    throw Exception('Could not launch $url');
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(start:2.0,
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
                                  onTap: () async {
                                    const  url ='https://www.instagram.com/ahmedzayan14/';
                                    if(await canLaunch(url)){
                                    await launch(url);
                                    }
                                    else{
                                    throw Exception('Could not launch $url');
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(start:4.0,
                                        ),
                                        child:SvgPicture.asset(
                                          'assets/images/instagram-logo-A807AD378B-seeklogo.com.svg',
                                          color: ColorsManager.primary,
                                          width:22.0,
                                          height: 22.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2.0,
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
                                CacheHelper.removeUserData(key: 'token')
                                    .then((value) {
                                 /* Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChangeLanguageScreen(),
                                      ),
                                      (route) => false);*/
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
