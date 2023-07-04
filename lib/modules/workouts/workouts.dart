// ignore_for_file: must_be_immutable
import 'package:blackgym/modules/exercises/details_training.dart';
import 'package:blackgym/shared/widgets/rate_user_widget.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/widgets/plan_exercises_widget.dart';
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
  get index => null;
  List<int> selectedIndexes=[];
      //AuthCubit.get(context).userModel!.data!.createdAt;
  @override
  Widget build(BuildContext context) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
    return BlocConsumer<GymCubit,GymStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = GymCubit.get(context);
        var planModel =cubit.planlModel;
       var   userModel= cubit.userModel! != null && cubit.userModel!.users! !=null&&cubit.userModel!.users!.rate![0]!=null?cubit.userModel!.users!.rate![0]:null;
          final regularity = double.parse(userModel!.regularity as String) ;
          final feeding = double.parse(userModel.feeding as String) ;
          final response = double.parse(userModel.response as String) ;
          final training = double.parse(userModel.training as String);
          final personality = double.parse(userModel.total as String);
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
                              planModel!.data!.data!.clear();
                              cubit.getPlan(day:'${DateFormat('EEEE').format((selectedDate))}'
                              );
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
                        backgroundBlendMode: BlendMode.screen,),
                         child:state is GetPlanLoading||state is GymChangeBottomNavBarState?
                             defaultProgressIndicator():
                               state is GetPlanError?
                                Center(
                                       child:Text('There is No Plan Today',
                                            style:TextStyle(
                                             color: ColorsManager.primary,
                                             fontSize:25,
                                             fontWeight: FontWeight.bold))):
                               planModel! !=null && planModel.data! !=null&& planModel.data!.data!.isNotEmpty?
                                     planExercises(planModel:planModel):
                                         SizedBox(),
                      ),
                      const SizedBox(height: 10.0,),
                       RateScreen(
                    training:training,//Training as double,
                    personality: personality,//Total as double,
                    feeding:feeding,//Feeding as double,
                    regularity:regularity,//Regularity  as double,
                    response:response, //Response as double,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
