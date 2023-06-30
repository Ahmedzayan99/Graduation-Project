// ignore_for_file: file_names

import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login/login.dart';
class HomeSignUpScreen extends StatefulWidget {
  const HomeSignUpScreen({Key? key}) : super(key: key);
  @override
  State<HomeSignUpScreen> createState() => _HomeSignUpScreenState();
}
class _HomeSignUpScreenState extends State<HomeSignUpScreen> {
  bool myProfile = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/abdominal muscles.png'),
          fit: BoxFit.fill, opacity: 150.0,),),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'assets/images/Logo.svg'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("${'becomeStronger..'.tr(context)}",
                      maxLines: 2,
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text("${'throughThisApplication'.tr(context)}",
                      maxLines: 4,
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),),
                    const SizedBox(height: 25.0,),
                    MaterialButton(
                      height: 54,
                      minWidth: double.infinity,
                      shape:StadiumBorder(),
                      color: ColorsManager.primary,
                      onPressed: () {
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (
                            context, animation, secondaryAnimation) =>
                            LoginScreen(),));
                      },
                      child: Text("${'logIn'.tr(context)}",
                          style: const TextStyle(
                            inherit: false,
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const SizedBox(height: 25.0,),
                    Text("This app belongs to BLACK GYM, and no one can register in it unless it has been added by our administrator. To register, you must visit us at our branches.",
                      maxLines: 4,
                      style: TextStyle(
                        inherit: false,
                        color: ColorsManager.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),),
                    const SizedBox(height: 40.0,),
                    Container(
                        width: double.infinity,
                        height: 25.0,
                        decoration: BoxDecoration(
                            color: ColorsManager.primary,
                            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              myProfile = !myProfile;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Our branches:",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  inherit: true,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.white,
                                ),
                              ),
                              Spacer(),
                              myProfile
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
                    ),
                    SizedBox(height: 15.0,),
                    if(myProfile)
                    Column(
                      children: [
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
                      ],
                    ),



                   /* MaterialButton(
                      height: 54,
                      minWidth: double.infinity,
                      shape: const StadiumBorder(),
                      color: ColorsManager.primary,
                      onPressed: () {
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (
                            context, animation, secondaryAnimation) =>
                        const ChangePlaceScreen(),));
                      },
                      child: Text("${'signUp'.tr(context)}",
                          style: const TextStyle(
                            inherit: false,
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),*/
                  ],
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
