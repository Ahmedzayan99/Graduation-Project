import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/styles/iconly_broken.dart';
import 'package:flutter/material.dart';
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