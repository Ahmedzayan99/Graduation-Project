import 'package:blackgym/modules/dummy/home_dummy.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer<GymCubit,GymStates>(
        listener:(context, state) =>{} ,
        builder:(context, state) {
          return ConditionalBuilder(
            condition:name !=null,
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
                            image: NetworkImage(image.toString()),
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
                            name.toString(),
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
                            description.toString(),
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
            fallback: (context) => defaultProgressIndicator(),

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