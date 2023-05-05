// ignore_for_file: must_be_immutable

import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/components.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
import '../../shared/widgets/paln_itim_widget.dart';
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
        var alan =GymCubit.get(context).plans;
      //  SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
      //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        return Scaffold(
          appBar: AppBar(
          ),
          body:Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior:Clip.antiAliasWithSaveLayer ,
                  decoration:BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                        // ignore: prefer_const_constructors
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
                          children: const [
                            SizedBox(width:10.0),
                            Text('MyPlan', style: TextStyle(color: Colors.white,fontSize: 16.0),),
                            Spacer(),
                           Icon(IconlyBroken.report,color:  Colors.grey,size: 40.0,)
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        Row(
                          children: [
                            const SizedBox(width:10.0),
                            const Text('Today', style: TextStyle( color: Colors.white,fontSize: 16.0),),
                            const Spacer(),
                            Text(date!,style: const TextStyle(color: Colors.grey),)
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        DatePicker(
                          border: const BorderSide(color: Colors.lightBlue,width: 2.0,),
                          locale: 'EN',
                          dateBarStartDay,
                          height:97.0,
                          width:80.0,
                          initialSelectedDate:todayDateBeforeFormat,
                          selectionColor:ColorsManager.primary,
                          deactivatedColor: Colors.red,
                          selectedTextColor: Colors.black,
                          dateTextStyle:const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'AsapCondensed-Bold',
                              color: Colors.white),
                          dayTextStyle:const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'AsapCondensed-Bold',
                              color: Colors.white),
                          monthTextStyle:const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'AsapCondensed-Bold',
                              color: Colors.white),

                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration:BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                          bottomStart: Radius.circular(10),
                          topStart:Radius.circular(40.0),
                          bottomEnd: Radius.circular(40.0,)
                      ),
                      color:ColorsManager.grey,
                      backgroundBlendMode: BlendMode.screen,
                    ) ,
                    child: ConditionalBuilder(
                      condition: alan.isNotEmpty,
                      builder: (context) {
                        return Padding(
                          padding:  const EdgeInsets.all(20.0),
                          child: ListView.separated(
                              itemBuilder: (context, index) => const NEWScreen(),
                              separatorBuilder:(context, index) => const SizedBox(height: 20.0),
                              itemCount:GymCubit.get(context).plans[1].play!.length),
                        );
                      },
                      fallback:(context) {
                        return Center(
                          child: defaultProgressIndicator(),
                        );

                      },
                    )
                    ,
                  ),
                ),
              ],
            ),
          ),


        );
      },
    );
  }


}
/**
 *   Widget NEWScreens(plays play, {bool value=false})=>Container(
    decoration: BoxDecoration(
    color: Colors.black45,
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    border: Border.all(color: ColorsManager.primary,width: 2.0,style: BorderStyle.solid),
    ),
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    children: [
    Container(
    height: 25.0,
    child: ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) =>
    Transform.scale(
    scale: 1.5,
    child: Checkbox(
    value: value,
    onChanged: ( value){
    } ,activeColor: Colors.blueAccent
    ),
    ),
    itemCount:play.set,
    ),
    ),
    SizedBox(height: 15.0,),
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Expanded(
    child: Column(
    children: [
    Container(
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
    image: AssetImage(''),
    fit: BoxFit.cover,),
    ),
    ),
    TextButton(onPressed: () {
    },
    child: const Text('Show more',
    style: TextStyle(
    color: Color.fromRGBO(255, 227, 40, 1),
    ),),
    )
    ],
    ),
    ),
    const SizedBox(width: 10.0,),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    ListView.separated(
    shrinkWrap: true,
    itemBuilder: (context, index) => Container(
    height: 30.0,
    width: double.infinity,
    margin: EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
    child: InkWell(
    onTap:() {
    },
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.center ,
    children: [
    Padding(
    padding: EdgeInsetsDirectional.only(start: 10.0),
    child: Text(
    'SET 1',
    style: TextStyle
    (
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold),),
    ),
    ],
    ),
    ),

    ),
    separatorBuilder:(context, index) => SizedBox(height: 15.0,),
    itemCount:play.set!,
    ),

    ],
    ),
    ),

    ],
    ),
    ],
    ),
    ),
    );

 *
 *
 *   Widget dateBar(DateTime now, context) {
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

 *
 *
 *   Widget aaa( Plan plan) =>Container(
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
    Text('plan',
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
 *
 *
 *
 * dateTextStyle: TextStyle(
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