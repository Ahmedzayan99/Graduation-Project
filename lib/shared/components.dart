import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/styles/iconly_broken.dart';
import 'package:flutter/material.dart';
Widget defaultProgressIndicator ()=>Center(
child: CircularProgressIndicator(
color: ColorsManager.primary,
));

/*Widget showProgressIndicator ()=>AlertDialog(

  backgroundColor: Colors.transparent,
  elevation: 0,
  content: Center(
    child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.primary)),),

);*/
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