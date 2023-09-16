
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/exercises/exercises_cubit.dart';
import '../../cubit/exercises/exercises_states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors_manager.dart';
// ignore: must_be_immutable
class DetailsTraining extends StatelessWidget {
final String? name;
final String? image;
final String? description;

  const DetailsTraining({Key? key, required this.name,
   required this.description,
     required this.image,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<ExercisesCubit,ExercisesStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if(name !=null&&image !=null &&description!=null){
            return Container(
            width: double.infinity,
          height: double.infinity,
          decoration:const BoxDecoration(
          image:DecorationImage(
          image:AssetImage(
          'assets/images/background1.png'),
          fit:BoxFit. fill,opacity: 180.0, ),),
          child:Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 241.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(
                                248, 202, 89, 0.6470588235294118),
                            width: 1.5,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage('${image}'),
                          fit: BoxFit.cover,),

                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '$name'.toUpperCase(),
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
                      '$description',
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
            ),
          ),
            );
          }
          else{
          return defaultProgressIndicator();
          }
        },
      );


  }
}
/* Container(
width: double.infinity,
height: double.infinity,
decoration: const BoxDecoration(
image:DecorationImage(
image: AssetImage("assets/images/background1.png"),fit: BoxFit.fill) ),),*/