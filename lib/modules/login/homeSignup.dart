import 'package:blackgym/modules/login/login/login.dart';
import 'package:blackgym/modules/login/register/signup.dart';
import 'package:flutter/material.dart';
class HomeSignUpScreen extends StatelessWidget {
  const HomeSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/abdominal muscles.png'),
            fit: BoxFit.fill,opacity: 150.0,),),
      child: Scaffold(
        appBar: AppBar(),
        body:Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             crossAxisAlignment: CrossAxisAlignment.center,
             children:[
               SizedBox(
                 child: Column(

                   children: const
                   [
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 25.0),
                       child: Text('Become Stronger with Our Workout Plans',
                       maxLines: 2,
                       style:TextStyle(
                         inherit: false,
                         color:Color.fromRGBO(255, 255, 255, 1),
                         fontSize: 20.0,
                         fontWeight: FontWeight.bold,
                       ),
                   ),
                     ),
                 SizedBox(height: 10.0,),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 10.0),
                   child: Text('Through this application, your health, weight, and height will be monitored, and through it, the plan will be developed, in front of a coach or without a coach.',
                     maxLines: 4,

                     style:TextStyle(
                       inherit: false,
                       color:Color.fromRGBO(255, 255, 255, 1),
                       fontSize:14.0,
                       fontWeight: FontWeight.w400,
                     ),),
                 ),],
                 ),
               ),
               const SizedBox(height: 30.0,),
               Container(
                 height: 52.0,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12.0),
                   color: const Color.fromRGBO(248, 202, 89, 1),
                 ),
                 child: MaterialButton(
                   onPressed: () {
                     Navigator.push(context, MaterialPageRoute(
                       builder: (context) => const LoginScreen(),),);

                   },
                   child: const Text(' Login',
                       style:TextStyle(
                     inherit: false,
                     color:Color.fromRGBO(0, 0, 0, 1),
                     fontSize:22.0,
                     fontWeight: FontWeight.bold,
                   )),
                 ),
               ),
               const SizedBox(height: 25.0,),
               Container(
                 height: 52.0,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12.0),
                   color: const Color.fromRGBO(248, 202, 89, 1),
                 ),
                 child: MaterialButton(
                   onPressed: () {
                     Navigator.push(context,
                         MaterialPageRoute(
                           builder: (context) =>  SignupScreen(),)
                     );
                   },
                   child: const Text(' Sign Up',
                       style:TextStyle(
                         inherit: false,
                         color:Color.fromRGBO(0, 0, 0, 1),
                         fontSize:22.0,
                         fontWeight: FontWeight.bold,
                       )),
                 ),
               ),
             ],

           ),
         ),
      ),
    );
  }
}
