
// ignore_for_file: file_names
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/widgets/note_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NoteDetails extends StatelessWidget {
   String? title;
   NoteDetails({super.key,this.title});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener:(context, state) {

      } ,
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text('Note',),
                Icon(Icons.notes,color: ColorsManager.primary),
              ],
            ),
          ),
          body:title!!=null?Container(
            width: double.infinity,
          height: double.infinity,
          decoration:const BoxDecoration(
            image:DecorationImage(
              image:AssetImage(
                  'assets/images/background1.png'),
              fit:BoxFit. fill,opacity: 180.0, ),),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              width: double.infinity,
              height: double.infinity,
               child: Text(title.toString(),
               style: TextStyle(
                   fontSize:25.0,
                       fontWeight: FontWeight.bold,
                 color: Colors.white,
                ),
               ),
            ),
          )
          ):Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty_outlined,
                    size: 60.0,
                    color: ColorsManager.primary),
                Text('There are no tasks. Add a new task',
                  style: TextStyle(
                    color: ColorsManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),)
              ],
            ),
          ),
        );
      },
    );
  }
}
