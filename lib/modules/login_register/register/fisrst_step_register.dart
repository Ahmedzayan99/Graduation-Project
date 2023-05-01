/*import 'package:blackgym/modules/login_register/register/second_step_register.dart';
import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_cubit.dart';
import 'package:blackgym/shared/logic/authentication_logic/authentication_states.dart';
import '../../../shared/styles/colors_manager.dart';
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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${'phoneNumber'.tr(context)}",
                  style: TextStyle(
                    inherit: false,
                    color: ColorsManager.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                Row(
                  children: [
                  Expanded(
                    flex: 3,
                    child:CustomTextFormFiled(
                      isPassword: false,
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "${'thisFieldRequired'.tr(context)}";
                        }
                        else if(value.length < 11)
                        {
                          return  "${'shortPhoneNumber'.tr(context)}";
                        }
                        else if(value.length >11)
                        {
                          return  "${'longPhoneNumber'.tr(context)}";
                        }
                        return null;
                      },
                      controller:phoneNumberController,
                      textInputType: TextInputType.phone,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${generateCountryFlag()}+02',
                          style:TextStyle(
                            color: ColorsManager.primary,
                            fontSize: 18,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      hintText:"${'phoneNumber'.tr(context)}",
                    ),),
                ],),
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
                  child:   Text("${'next'.tr(context)}",
                      style:const TextStyle(
                        inherit: false,
                        color:Colors.black,
                        fontSize:20.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          );
        },
    );
  }
}
*/