import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final IconData? icon;
  const CustomTextFormFiled({Key? key, required this.controller, this.textInputType, this.validator, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller ,
      keyboardType: textInputType,
      style: const TextStyle( color: Colors.black,
        fontSize: 14.0,),
      decoration: InputDecoration(
        prefixIcon: Icon(icon,),
      ),
    );
  }
}
