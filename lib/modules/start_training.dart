import 'package:blackgym/shared/widgets/training_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/cubit/cubit.dart';
import 'package:blackgym/shared/cubit/states.dart';
import 'package:blackgym/modules/dummy/training_dummy.dart';

class StartTraining extends StatelessWidget {
  const StartTraining({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GymCubit(),
      child: BlocConsumer<GymCubit,GymStates>(
        listener:(context, state) =>{} ,
        builder:(context, state) =>  Container(
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
                      itemBuilder: (context, index) {
                      var trainingItemDummy = trainingDummy[index];
                      return TrainingItemWidget(train: trainingItemDummy);
                      },
                      separatorBuilder:(context, index) => const SizedBox(height: 10.0,),
                      itemCount: trainingDummy.length),

                ],
              ),
            ),
              ),

          ),
        ),

      ),
    );
  }
}
