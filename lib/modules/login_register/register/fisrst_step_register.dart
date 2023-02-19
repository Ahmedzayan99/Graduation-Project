import 'package:blackgym/modules/login_register/register/otp_screen.dart';
import 'package:blackgym/modules/login_register/register/second_step_register.dart';
import 'package:flutter/material.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_states.dart';
import '../../../shared/styles/colors_manager.dart';
import '../../../shared/styles/string_manager.dart';
import '../../../shared/widgets/custom_text_form_filed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
 SignupScreen({Key? key}) : super(key: key);
 final TextEditingController phoneNumberController=TextEditingController();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 void showProgressIndicator(BuildContext  context)
 {
    AlertDialog alertDialog = AlertDialog(
     backgroundColor: Colors.transparent,
     elevation: 0,
     content: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.primary)),),
   );

   showDialog(
       barrierColor: Colors.white.withOpacity(0),
       barrierDismissible: false,
       context: context, builder: (context)
   {
     return alertDialog;
   });
 }

 String generateCountryFlag() {
   String countryCode = 'eg';
   String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
           (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
   return flag;
 }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AuthCubit,AuthStates>(
      listener:(context, state) {
        if (state is PhoneLoadingState) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSubmitted) {


          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) =>SignupUserScreen(phone:phoneNumberController.text.trim()),
            //OTPScreen(phoneNumber: phoneNumberController.text.trim(),)
          ), (route) => false);
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
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/abdominal muscles.png'),
                  fit: BoxFit.fill,opacity: 150.0),),
            child: Scaffold(
              appBar:AppBar(),
              body:Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.phoneNumber,
                        style: TextStyle(
                          inherit: false,
                          color: ColorsManager.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),),
                      Row(children: [
                        Expanded(
                            flex: 1,
                            child: Container(

                              padding: const EdgeInsets.symmetric(vertical: 16),
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(

                                  border: Border.all(
                                    color:ColorsManager.primary,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(6))),
                              child: Text(
                                '${generateCountryFlag()}+02',
                                style: const TextStyle(fontSize: 18, letterSpacing: 2.0),
                              ),
                            )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 2,
                          child:CustomTextFormFiled(
                            isPassword: false,
                            validator: (value) {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your phone number!';
                              }
                              else if(value.length < 11)
                              {
                                return 'Too short for phone number !';
                              }
                              return null;
                            },
                            controller:phoneNumberController,
                            textInputType: TextInputType.phone,
                            icon: Icons.phone,
                            hintText: AppString.enterPhoneNumber,
                          ),),
                      ],),


                      const SizedBox(height: 30.0,),
                      MaterialButton(
                        height: 54,
                        minWidth: double.infinity,
                        shape: const StadiumBorder(),
                        color: ColorsManager.primary,
                        onPressed: () {
                          showProgressIndicator(context);
                          if(_formKey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) =>SignupUserScreen(phone:phoneNumberController.text.trim())  ), (route) => false);
                          //  Navigator.pop(context);
                          //  AuthCubit.get(context).submitPhoneNumber(
                       //         phoneNumberController.text.trim());
                          }
                          else {
                            Navigator.pop(context);
                            return;
                          }
                          },
                        child:  const Text('Next',
                            style:TextStyle(
                              inherit: false,
                              color:Colors.black,
                              fontSize:20.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
