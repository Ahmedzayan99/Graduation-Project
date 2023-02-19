import 'package:blackgym/model/start_training_model.dart';
import 'package:blackgym/modules/dummy/home_dummy.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import '../../shared/styles/colors_manager.dart';

// ignore: must_be_immutable
class DetailsTraining extends StatelessWidget {
  late SelectTrain bigDetails;
   DetailsTraining({Key? key, required this.bigDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
        listener:(context, state) =>{} ,
        builder:(context, state) {
          return ConditionalBuilder(
            condition:homeTrainingDummy[1].data.isNotEmpty,
            builder: (context) => 
                Scaffold(backgroundColor: ColorsManager.black,
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(

                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 241.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(248, 202, 89, 1.9),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage(bigDetails.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background1.png'),
                            fit: BoxFit.cover,opacity:100.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            bigDetails.lebol,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              color: Color.fromRGBO(251, 251, 251, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            bigDetails.details,
                            style:  TextStyle(
                              color: ColorsManager.grey,
                              fontWeight: FontWeight.w700,
                              height: 2.5,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),

            ),
            fallback: (context) =>  Center(child:CircularProgressIndicator(color:ColorsManager.primary,)),

          );

        }

    );
  }
}
/* Container(
width: double.infinity,
height: double.infinity,
decoration: const BoxDecoration(
image:DecorationImage(
image: AssetImage("assets/images/background1.png"),fit: BoxFit.fill) ),),*/