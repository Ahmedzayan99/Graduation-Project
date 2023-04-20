import 'package:blackgym/shared/widgets/paln_itim_widget.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/logic/home_logic/cubit.dart';
import '../../shared/logic/home_logic/states.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
class WorkoutsScreen extends StatelessWidget {
  var dateBarStartDay = DateTime.now();
  var todayDateBeforeFormat = DateTime.now();
  String? date = DateFormat('EEEE,dd MMMM').format((DateTime.now()));
  WorkoutsScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
    return BlocConsumer<GymCubit, GymStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        return Scaffold(
          appBar: AppBar(
          ),
          resizeToAvoidBottomInset: false,
          body:Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior:Clip.antiAliasWithSaveLayer ,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                        bottomStart: Radius.circular(10),
                        topStart:Radius.circular(40.0),
                      bottomEnd: Radius.circular(40.0,)
                      ),
                      color:ColorsManager.grey,
                    backgroundBlendMode: BlendMode.screen,
                  ) ,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width:10.0),
                            Text('MyPlan', style: TextStyle(color: Colors.white,fontSize: 16.0),),
                            Spacer(),
                           Icon(IconlyBroken.report,color:  Colors.grey,size: 40.0,)
                          ],
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          children: [
                            SizedBox(width:10.0),
                            Text('Today', style: TextStyle( color: Colors.white,fontSize: 16.0),),
                            Spacer(),
                            Text(date!,style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                        SizedBox(height: 20.0,),
                        DatePicker(
                          border: BorderSide(color: Colors.lightBlue,width: 2.0,),
                          locale: 'EN',
                          dateBarStartDay,
                          height:97.0,
                          width:80.0,
                          initialSelectedDate:todayDateBeforeFormat,
                          selectionColor:ColorsManager.primary,
                          deactivatedColor: Colors.red,
                          selectedTextColor: Colors.black,
                          dateTextStyle:TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'AsapCondensed-Bold',
                              color: Colors.white),
                          dayTextStyle:TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'AsapCondensed-Bold',
                              color: Colors.white),
                          monthTextStyle:TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'AsapCondensed-Bold',
                              color: Colors.white),

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 470.0,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(10),
                        bottomStart: Radius.circular(10),
                        topStart:Radius.circular(40.0),
                        bottomEnd: Radius.circular(40.0,)
                    ),
                    color:ColorsManager.grey,
                    backgroundBlendMode: BlendMode.screen,
                  ) ,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) => NEWScreen(),
                        separatorBuilder:(context, index) => SizedBox(height: 20.0),
                        itemCount: 10),
                  )
                  ,
                ),

              ],
            ),
          ),


        );
      },
    );
  }
  Widget dateBar(DateTime now, context) {
    var appCubit = GymCubit.get(context);
    return DatePicker(
      border: BorderSide(color: Colors.redAccent,width: 1.0,style: BorderStyle.solid),
      locale: appCubit.lang,
      dateBarStartDay,
      height: 11.2,
      width: 19,
      initialSelectedDate:todayDateBeforeFormat,
      selectionColor:Colors.white,
      deactivatedColor: Colors.red,
      selectedTextColor: Colors.white,
    );
  }
    Widget aaa(BuildContext context) =>Container(
      decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
      border: Border.all(color: ColorsManager.primary,width: 2.0,style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 157.0,
                height: 141.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(
                          248, 202, 89, 0.6470588235294118),
                      width: 1.5,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/back.jpg'),
                    fit: BoxFit.cover,),

                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('aaaaaaaaaaaaa',
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Color.fromRGBO(251, 251, 251, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                  SizedBox(
                    height: 93.0,
                    child: Text('aaaaaaaaaaaaaaa',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromRGBO(188, 186, 186, 1),
                        fontWeight: FontWeight.w200,
                        fontSize: 12.0,
                      ),),
                  ),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  },
                    child: const Text('Show more',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 227, 40, 1),
                      ),),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
}
/**   dateTextStyle: TextStyle(
    fontSize: 16.8.,
    fontFamily: 'AsapCondensed-Bold',
    color: Colors.black,
    dayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
    color: AppCubit.get(context).darkMode == false
    ? Colors.black
    : Colors.grey),
    monthTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
    color: AppCubit.get(context).darkMode == false
    ? Colors.black
    : Colors.grey),
    onDateChange: (onDate) {
    now = onDate;
    AppCubit.get(context).dateBarToggle(onDate);
    },
    **/