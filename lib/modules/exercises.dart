import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/widgets/home_training_item_widget.dart';
import 'dummy/home_dummy.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:homeTrainingDummy[0].details.isNotEmpty,
          builder:(context) =>  Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisExtent: 370,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 14.0,
            ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children:List.generate(homeTrainingDummy.length,(index){
                var homeDummyItem =  homeTrainingDummy[index];
                return HomeTrainingItemWidget(selectTraining:homeDummyItem,);
              }),),
          ),
          fallback: (context) => const Center(child:CircularProgressIndicator()),
        );
      },
    );
  }
}
/*
*/