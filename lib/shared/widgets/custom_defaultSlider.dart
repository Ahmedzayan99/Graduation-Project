
// ignore_for_file: must_be_immutable, unnecessary_string_interpolations, file_names

import 'package:flutter/material.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
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
