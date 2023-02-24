import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';
Widget defaultProgressIndicator ()=>Center(
child: CircularProgressIndicator(
color: ColorsManager.primary,
));
/**
    import 'package:blackgym/shared/styles/colors_manager.dart';
    import 'package:blackgym/shared/styles/string_manager.dart';
    import 'package:flutter/material.dart';
Widget defaultSlider ({
  double? heightOfContainer,
  double? widthOfContainer,
  Color? colorOfContainer,
  BorderRadius?  borderRadiusOfContainer,
})=>
Container(
height: heightOfContainer ?? 125.0,
width:  widthOfContainer??double.infinity,
    decoration: BoxDecoration(
               color: colorOfContainer??ColorsManager.grey,
               borderRadius: borderRadiusOfContainer??const BorderRadius.all(Radius.circular(15.0,))),
      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(AppString.height,
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.white,
                    fontSize: 20.0),),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline:TextBaseline.alphabetic,
                    children: [
                    Text('${cubit.heightInitial.round()}',
                    style:  TextStyle(
                    color:  ColorsManager.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 30.0),),
                    const SizedBox(width:3.0,),
                    Text('cm',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.primary,
                    fontSize: 18.0),
                    ),
                    ],
                    ),
                    Slider(
                    activeColor: ColorsManager.primary,
                    thumbColor:ColorsManager.primary,
                    value:cubit.heightInitial,
                    min: 80,
                    max: 240,
                    onChanged:(value) {
                    cubit.changeHeight(height:value);
                    },
                    ),
                    ],
                    ),
                    ),
**/