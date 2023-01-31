import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? icon;
  final IconButton? iconButton;
   bool isPassword =false;
   CustomTextFormFiled({Key? key,
     this.controller,
    this.textInputType,
    this.validator,
    this.hintText,
    this.icon,
    this.iconButton,
     bool? obscureText,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:isPassword,
      validator: validator,
      controller: controller ,
      keyboardType: textInputType,
      style:  TextStyle( color:ColorsManager.primary,
        fontSize: 14.0,),
      decoration: InputDecoration(
         hintText:  hintText,
        prefixIcon: Icon(icon,),
        suffixIcon: iconButton,
      ),
    );
  }
}
