import 'package:flutter/material.dart';

import '../styles/colors_manager.dart';
Widget defaultProgressIndicator ()=>Center(
child: CircularProgressIndicator(
color: ColorsManager.primary,
));

void showProgressIndicator(BuildContext  context)
{
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.grey,
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

void showErrorMassage(context)
{
  AlertDialog alertDialog =   AlertDialog(
    backgroundColor: ColorsManager.grey,
    actionsAlignment: MainAxisAlignment.start,
    buttonPadding: EdgeInsets.all(0),
    scrollable: true,
    //elevation: 70.0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    content:Container(
      height: 20.0,
      child: Row(
      children: [
        Text('Internet connection error',
            style: TextStyle(
              color: ColorsManager.primary,
              fontWeight: FontWeight.w400,
              fontSize: 14,)),
        SizedBox(width: 5.0,),
        CircularProgressIndicator(
          color: ColorsManager.primary,
          strokeWidth: 2.0,
        ),
      ],
    ),
    ),
  );
  showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: true,
      context: context,
      builder: (context)

  {
    return alertDialog;
  });
}

class CustomDefaultSlider extends StatelessWidget {
  final    double? heightOfContainer;
  final    double? widthOfContainer;
  final    Color? colorOfContainer;
  final    BorderRadius?  borderRadiusOfContainer;
  final String textOfTitle;
  final String showValue;
  final double value;
  final double max;
  final double min;
  final String textAlphabetic;
  void Function(double) onChanged;

  CustomDefaultSlider({
    Key? key,
    this.heightOfContainer,
    this.widthOfContainer,
    this.colorOfContainer,
    this.borderRadiusOfContainer,
    required this.textOfTitle,
    required this.max,
    required this.min,
    required this.showValue,
    required this.value,
    required this.textAlphabetic,
    required this.onChanged,

  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightOfContainer ?? 150.0,
      width:  widthOfContainer??double.infinity,
      decoration: BoxDecoration(
          color: colorOfContainer??ColorsManager.grey,
          borderRadius: borderRadiusOfContainer??const BorderRadius.all(Radius.circular(15.0,))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textOfTitle,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.white,
                  fontSize: 18.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline:TextBaseline.alphabetic,
              children: [
                Text('$showValue',
                  style:  TextStyle(
                      color:  ColorsManager.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0),),
                const SizedBox(width:3.0,),
                Text(textAlphabetic,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.primary,
                      fontSize: 12.0),
                ),
              ],
            ),
            Slider(
              activeColor: ColorsManager.primary,
              thumbColor:ColorsManager.primary,
              value:value,
              min: min,
              max: max,
              onChanged:onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
class CustomTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final String? hintText;
  final Widget? icon;
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
    this.isPassword = false,
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
        prefixIcon: icon ,
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
