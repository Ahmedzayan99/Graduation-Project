import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/widgets/training_item_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/start_training_model.dart';
import 'package:blackgym/shared/components.dart';


class StartTraining extends StatelessWidget {
  final List<SelectTrain> data;
   const StartTraining({Key? key, required this.data}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
         listener:(context, state) =>{} ,
          builder:(context, state) {
             return ConditionalBuilder(
               condition:data.isNotEmpty,
               builder: (context) => Container(
                 width: double.infinity,
                 height: double.infinity,
                 decoration: const BoxDecoration(
                     image:DecorationImage(
                         image: AssetImage("assets/images/background1.png"),fit: BoxFit.fill) ),
                 child: Scaffold(
                   appBar: AppBar(),
                   body: SingleChildScrollView(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                       child: Column(
                         children: [
                           ListView.separated(
                               shrinkWrap:true,
                               physics: const NeverScrollableScrollPhysics(),
                               itemBuilder: (context, index)
                               {
                                 var trainingItemDummy =data[index];
                                 return TrainingItemWidget(train:trainingItemDummy,);
                               },
                               separatorBuilder:(context, index) => const SizedBox(height: 10.0,),
                               itemCount: data.length),

                         ],
                       ),
                     ),
                   ),

                 ),
               ),
               fallback: (context) => defaultProgressIndicator(),

             );

    }

    );
  }
}
