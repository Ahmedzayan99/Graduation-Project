// ignore_for_file: non_constant_identifier_names

import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/exercises/start_training.dart';

class HomeTrainingItemWidget extends StatelessWidget {
  const HomeTrainingItemWidget({
    Key? key,
  }) : super(key: key);

  get state => null;

  @override
  Widget build(BuildContext context) {
    var cubit = GymCubit.get(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 60.0,
        start: 20.0,
        end: 20.0,
        bottom: 20.0,
      ),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisExtent: 370,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 14.0,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(cubit.musclesModel!.data!.length, (index) {
          return SizedBox(
            height: 400.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 275.0,
                  height: 182.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(248, 202, 89, 1.9),
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image:
                      NetworkImage(cubit.musclesModel!.data![index].image.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 11.0,
                ),
                Text(
                  cubit.musclesModel!.data![index].name.toString().toUpperCase(),
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
                SizedBox(
                  height: 99.0,
                  child: Text(
                    cubit.musclesModel!.data![index].description.toString(),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromRGBO(188, 186, 186, 1),
                      fontWeight: FontWeight.w200,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                ConditionalBuilder(
                  condition: state is! GetOnlyMusclesLoading,
                  builder: (context)=>Container(
                    height: 27.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70.0),
                      color: const Color.fromRGBO(248, 202, 89, 1),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        GymCubit.get(context).getOnlyMuscles1(id: cubit.musclesModel!.data![index].id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StartTraining(),
                          ),
                        );
                      },
                      child: const Text('Start training'),
                    ),
                  ),
                  fallback: (context)=>defaultProgressIndicator(),
                ),

              ],
            ),
          );
        }),
      ),
    );
  }
}
