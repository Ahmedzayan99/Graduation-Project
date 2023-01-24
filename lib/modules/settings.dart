

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../shared/styles/iconly_broken.dart';
import 'login/homeSignup.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
  String image ="assets/images/zay.jpg";
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(right: 25,left: 25,top: 20,bottom: 20,),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 40.0,
                decoration: const BoxDecoration(
                    color:Color.fromRGBO(101, 99, 99, 1.0),
                    borderRadius:BorderRadius.all(Radius.circular(10.0))
                ),
                child:InkWell(
                  onTap: () {

                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       const Padding(
                         padding: EdgeInsets.only(left: 2.0),
                         child: Icon(IconlyBroken.profile,
                          color: Color.fromRGBO(248, 202, 89, 1),),
                       ),
                      const SizedBox(width: 2.0,),
                      const Text('My profile',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Color.fromRGBO(251, 251, 251, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width:40.0,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.navigate_next,color: Color.fromRGBO(251, 251, 251, 1), ),
                          ],
                        ),),

                    ],
                  ),
                ) ,),
              const SizedBox(height: 15.0,),
              Container(
                width: double.infinity,
                height: 40.0,
                decoration: const BoxDecoration(
                    color:Color.fromRGBO(101, 99, 99, 1.0),
                    borderRadius:BorderRadius.all(Radius.circular(10.0))
                ),
                child:InkWell(
                  onTap: () {
                  },

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        IconlyBroken.back,
                        color: Color.fromRGBO(248, 202, 89, 1),),
                      const SizedBox(width: 2.0,),
                      const Text('My Coach',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Color.fromRGBO(251, 251, 251, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width:40.0,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.navigate_next,color: Color.fromRGBO(251, 251, 251, 1), ),
                          ],
                        ),),

                    ],
                  ),
                ) ,),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 40.0,
                decoration: const BoxDecoration(
                    color:Color.fromRGBO(101, 99, 99, 1.0),
                    borderRadius:BorderRadius.all(Radius.circular(10.0))
                ),
                child:InkWell(
                  onTap: () {
                  },

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.language_sharp,
                        color: Color.fromRGBO(248, 202, 89, 1),),
                      const SizedBox(width: 2.0,),
                      const Text('Language',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Color.fromRGBO(251, 251, 251, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width:40.0,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.navigate_next,color: Color.fromRGBO(251, 251, 251, 1), ),
                          ],
                        ),),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),

              Container(
                width: double.infinity,
                height:200.0,
                decoration: const BoxDecoration(
                    color:Color.fromRGBO(101, 99, 99, 1.0),
                    borderRadius:BorderRadius.all(Radius.circular(10.0))
                ),
                child: Column(
                  children: const [
                    ListTile(
                      dense: true,
                      title: Text("Rate the App",
                        style: TextStyle(
                          color:Color.fromRGBO(251, 251, 251, 1),
                          fontSize: 14.0,

                        ),),
                      leading: Icon(Icons.star_rate_rounded,
                        color: Color.fromRGBO(
                            248, 202, 89, 1),),
                    ),
                    ListTile(
                  dense: true,
                  title: Text("Share with Friends",
                    style: TextStyle(
                      color: Color.fromRGBO(251, 251, 251, 1),
                      fontSize: 14.0,

                    ),),
                  leading: Icon(Icons.share,
                    color: Color.fromRGBO(
                        248, 202, 89, 1),),
                ),
                    ListTile(
                      dense: true,
                      title: Text("Our Facebook",
                        style: TextStyle(
                          color:Color.fromRGBO(251, 251, 251, 1),
                          fontSize: 14.0,

                        ),),
                      leading: Icon(Icons.facebook,
                        color: Color.fromRGBO(
                            248, 202, 89, 1),),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Our instagram",
                        style: TextStyle(
                          color: Color.fromRGBO(251, 251, 251, 1),
                          fontSize: 14.0,

                        ),),
                      leading: Icon(Icons.motion_photos_on_outlined,
                        color: Color.fromRGBO(
                            248, 202, 89, 1),),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0,),
              Container(
                width: double.infinity,
                height:51.0,
                decoration: const BoxDecoration(
                    color:Color.fromRGBO(101, 99, 99, 1.0),
                    borderRadius:BorderRadius.all(Radius.circular(10.0))
                ),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: const Text("Log Out",
                        style: TextStyle(
                          color: Color.fromRGBO(251, 251, 251, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),),
                      leading: const Icon(Icons.logout,
                        color: Color.fromRGBO(
                            248, 202, 89, 1),),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) =>  const HomeSignUpScreen(),), (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}