// ignore_for_file: must_be_immutable, avoid_print

import 'package:blackgym/model/home_training_model.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
class NotasBuilder extends StatelessWidget {
 List<Notes> tasks;
  //List<Map> tasks;
  NotasBuilder({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: tasks!.isNotEmpty,
        builder: (BuildContext context) =>
            ListView.separated(
              itemBuilder: (context,  index,) {
                final task=tasks![index];
                // print('task status ${tasks[index]['status']}');
                return buildTaskItem(task, context, index);
              },
              separatorBuilder: (context, index) =>
                  Container(
                    width: double.infinity,
                    height: 0.2,
                    color: Colors.grey[300],
                  ),
              itemCount: tasks!.length,
            ),
        fallback: (BuildContext context) =>
            Center(
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
            ));
  }
}
Widget buildTaskItem(Notes model,context, int index,) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        backgroundColor: ColorsManager.primary,
        maxRadius: 40.0,
        child:Text('${model.time}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
      ),
      const SizedBox(
        width: 15.0,
      ),
      Expanded(
        child:   Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            Text(
              '${model.title}',
              style: const TextStyle(
                fontSize:18.0,color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 10.0,),
            Text('${model.data}',
              style: const TextStyle(
                color: Colors.white,
              ),)
          ],
        ),
      ),
      const SizedBox(
        width: 15.0,
      ),
      model.status=='done'?const SizedBox():IconButton(
        onPressed:(){
         GymCubit.get(context).updateNotes(
           title:'${model.title}',
           time: '${model.time}',
            data: '${model.data}',
             id: '${model.id}',
          );
        },
        icon:  Icon(Icons.check_circle_outline_outlined,color: ColorsManager.primary),),
      IconButton(
          onPressed:(){
            GymCubit.get(context).deleteNotes(id:'${model.id}');
          },
          icon:  Icon(Icons.delete,color:  ColorsManager.primary)),
    ],
  ),
);