// ignore_for_file: must_be_immutable

import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final String? hintText;
  final IconData? icon;
  final Function? suffixOnPressed;
  final bool isPassword;

  const CustomTextFormFiled({
    Key? key,
    this.controller,
    this.textInputType,
    this.validator,
    this.suffixIcon,
    this.suffixOnPressed,
    this.hintText,
    this.icon,
    this.isPassword = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      validator: (value) {
        return validator!(value);
      },
      controller: controller,
      keyboardType: textInputType,
      style: TextStyle(
        color: ColorsManager.primary,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
        ),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 1, bottom: 1),
                child: IconButton(
                    icon: Icon(
                      suffixIcon,
                      size: 22,
                    ),
                    onPressed: () {
                      suffixOnPressed!();
                    }),
              )
            : null,
      ),
    );
  }
}
