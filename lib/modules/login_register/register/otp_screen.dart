// ignore_for_file: avoid_print, unnecessary_import, unnecessary_string_interpolations, must_be_immutable

import 'package:blackgym/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/styles/colors_manager.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_states.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'second_step_register.dart';

class OTPScreen extends StatelessWidget {
  final TextEditingController verificationController=TextEditingController();
  final TextEditingController pinController=TextEditingController();
  GlobalKey<FormState> formKey =GlobalKey<FormState>();
  final String phoneNumber;
  OTPScreen({Key? key,required this.phoneNumber}) : super(key: key);

  void showProgressIndicator(BuildContext  context)
  {
     AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.primary)),),
    );

    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context, builder: (context)
    {
      return alertDialog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener:(context, state) {
        if (state is PhoneLoadingState) {
          showProgressIndicator(context);
        }
        if (state is PhoneOTPVerified) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => SignupUserScreen(phone: phoneNumber,)), (route) => false);
        }
        if (state is PhoneErrorState) {

          Navigator.pop(context);
          String errorMsg = (state).error!;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMsg),
                backgroundColor: Colors.black,
                duration: const Duration(seconds: 10),)
          );
        }
      },
      builder:(context, state) {
        return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Verify your phone number',
                            style: TextStyle(
                                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: RichText(
                              text:  TextSpan(
                                  text: 'Enter the 6-digit number that was sent to ',
                                  children:
                                  <TextSpan>
                                  [
                                    TextSpan(text: phoneNumber, style: const TextStyle(color: Colors.blue))
                                  ],
                                  style: const TextStyle(fontSize: 18, color: Colors.black, height: 1.4,)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 88,
                      ),
                      PinCodeTextField(
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'error';
                          }
                          return null;
                        },
                        controller: pinController,
                        autoFocus: true,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.scale,
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        onCompleted: (code) {
                          print(code);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            borderWidth: 1,
                            activeColor:Colors.blue,
                            inactiveColor: Colors.blue,
                            inactiveFillColor: Colors.white,
                            activeFillColor: Colors.lightBlue,
                            selectedColor: Colors.blue,
                            selectedFillColor: Colors.white
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: ElevatedButton(
                          onPressed: ()
                          {
                            defaultProgressIndicator();
                            if(formKey.currentState!.validate()){
                              print("${pinController.text}");
                              AuthCubit.get(context).submitOTP(pinController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(110, 50),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              )
                          ),
                          child: const Text('Verify', style: TextStyle(color: Colors.white, fontSize: 16),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}