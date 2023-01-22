import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
 SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/abdominal muscles.png'),
            fit: BoxFit.fill,opacity: 150.0),),
      child: Scaffold(
        appBar:AppBar(),
      ),
    );
  }
}
