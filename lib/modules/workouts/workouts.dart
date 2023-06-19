// ignore_for_file: must_be_immutable
import 'package:blackgym/modules/exercises/details_training.dart';
import 'package:blackgym/modules/workouts/chart.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/components.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
class WorkoutsScreen extends StatefulWidget {

  const WorkoutsScreen({Key? key,}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
      //AuthCubit.get(context).userModel!.data!.createdAt;
  bool value=false;

  get index => null;

  @override
  Widget build(BuildContext context) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
    return BlocConsumer<GymCubit,GymStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = GymCubit.get(context);
     SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        return Scaffold(
          appBar: AppBar(),
          body:SingleChildScrollView(
            child: Padding(
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
                              Text(cubit.date!,style: const TextStyle(color: Colors.grey),)
                            ],
                          ),
                          const SizedBox(height: 20.0,),
                          DatePicker(
                            controller:cubit.today,
                            onDateChange: (selectedDate) {
                              cubit.todayDateBeforeFormat =selectedDate;
                              cubit.getPlan(id: '35',day:'${DateFormat('EEEE').format((selectedDate))}');
                            },
                            locale: 'EN',
                            cubit.dateBarStartDay,
                            height:97.0,
                            width:80.0,
                            initialSelectedDate:cubit.todayDateBeforeFormat,
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
                            daysCount: 7 ,

                          ),
                        ],
                      ),
                    ),
                  ),
                      const SizedBox(height: 10.0,),
                      Container(
                      height: 400.0,
                     // clipBehavior: Clip.antiAliasWithSaveLayer,
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
                        condition: state is! GetPlanLoading,
                        builder:(context) {
                          return Padding(
                          padding:  const EdgeInsets.all(20.0),
                          child: ListView.separated(
                          physics:BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap:true ,
                          itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                          border: Border.all(
                          color: const Color.fromRGBO(
                          248, 202, 89, 0.6470588235294118),
                          width: 1.5,
                          style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                          children: [
                          Row(
                          children: [

                          Expanded(
                          child: cubit.value1 == false
                    //      || CacheHelper.getDataIntoShPre(key: "value1") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ),
                          cubit.planlModel?.data![index].exercise?.groups == 2 ||
                          cubit.planlModel?.data![index].exercise?.groups == 3 ||
                          cubit.planlModel?.data![index].exercise?.groups == 4 ?
                          Expanded(
                          child: cubit.value2 == false
                       //   || CacheHelper.getDataIntoShPre(key: "value2") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ):const SizedBox(),
                          cubit.planlModel?.data![index].exercise?.groups == 3 ||
                          cubit.planlModel?.data![index].exercise?.groups == 4?
                          Expanded(
                          child: cubit.value3 == false
                          || CacheHelper.getDataIntoShPre(key: "value3") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ):const SizedBox(),
                          cubit.planlModel?.data![index].exercise?.groups == 4 ?
                          Expanded(
                          child: cubit.value4 == false
                          || CacheHelper.getDataIntoShPre(key: "value4") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ):const SizedBox(),
                          ],
                          ),
                          const SizedBox(height: 15.0,),
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
                          image:  DecorationImage(
                          image: NetworkImage(
                          cubit.planlModel!.data![index].exercise!.image as String),
                          fit: BoxFit.cover,),
                          ),
                          ),
                          TextButton(onPressed: () {
                          Navigator.push(context,
                          PageRouteBuilder(
                          pageBuilder:(context, animation, secondaryAnimation) =>
                          DetailsTraining(
                          name:cubit.planlModel!.data![index].exercise!.name ,
                          image:cubit.planlModel!.data![index].exercise!.image ,
                          description:cubit.planlModel!.data![index].exercise!.description ,),),);
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
                          InkWell(
                          child: Container(
                          width: double.infinity,
                          height: 37,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
                          margin: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
                          child: const Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                          'set 1',
                          style: TextStyle
                          (
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                          ),
                          ),
                          onTap: (){
                            cubit.setValueCheckOne();
                          print(index);
                          },
                          ),
                          const SizedBox(height: 10),
                          cubit.planlModel?.data![index].exercise?.groups ==2||
                          cubit.planlModel?.data![index].exercise?.groups ==3 ||
                          cubit.planlModel?.data![index].exercise?.groups ==4 ?
                          InkWell(
                          child: Container(
                          width: double.infinity,
                          height: 37,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
                          margin: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
                          child: const Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                          'set 2',
                          style: TextStyle
                          (
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                          ),
                          ),
                          onTap: (){
                          cubit.setValueCheckTwo();
                          },
                          )
                              :const SizedBox(),
                          const SizedBox(height: 10),
                          cubit.planlModel?.data![index].exercise?.groups ==3 ||
                          cubit.planlModel?.data![index].exercise?.groups ==4 ?
                          InkWell(
                          child: Container(
                          width: double.infinity,
                          height: 37,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
                          margin: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
                          child: const Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                          'set 3',
                          style: TextStyle
                          (
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                          ),
                          ),
                          onTap: (){
                          cubit.setValueCheckThree();
                          print(index);
                          },
                          )
                              :const SizedBox(),
                          const SizedBox(height: 10),
                          cubit.planlModel?.data![index].exercise?.groups ==4 ?
                          InkWell(
                          child: Container(
                          width: double.infinity,
                          height: 37,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
                          margin: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
                          child: const Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                          'set 4',
                          style: TextStyle
                          (
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                          ),
                          ),
                          onTap: (){
                          cubit.setValueCheckFour();
                          },
                          ):const SizedBox(),
                          ],
                          ),
                          ),
                          ],
                          ),
                          ],
                          ),
                          ),
                          ),
                          separatorBuilder: (context, index) {
                          return const SizedBox(height: 20,);},
                          itemCount:cubit.planlModel!.data!.length ),
                          );
                        },
                          fallback: (context) {
                      return showProgressIndicator();
                      },
                      ),
                    ),
                      const SizedBox(height: 10.0,),
                       ActivityScreen(),
                ],
              ),
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
