// ignore_for_file: must_be_immutable, avoid_print

import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
class NotasBuilder extends StatelessWidget{
  List<Map> tasks;
   NotasBuilder({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: tasks.isNotEmpty,
        builder:(BuildContext context)=> ListView.separated(
          itemBuilder: (context, index) {
            print('task status ${tasks[index]['status']}');
            return buildTaskItem(tasks[index],context);
          },
          separatorBuilder:(context, index) => Container(
            width: double.infinity,
            height: 0.2,
            color: Colors.grey[300],
          ),
          itemCount: tasks.length,
        ),
        fallback:(BuildContext context)=> Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
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
Widget buildTaskItem(Map model,context) => Dismissible(
  key: Key(
    model['id'].toString(),
  ),
  direction: DismissDirection.horizontal,
  onDismissed: (direction) {
    GymCubit.get(context).deleteFromDatabase(id: model['id']);
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: ColorsManager.primary,
          maxRadius: 40.0,
          child:Text('${model['time']}',
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
                '${model['title']}',
                style: const TextStyle(
                  fontSize:18.0,color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              Text('${model['date']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),)
            ],
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        model['status']=='done'?const SizedBox():IconButton(
          onPressed:(){
            GymCubit.get(context).updateToDatabase(
              status: 'done',id: model['id'],
            );
          },
          icon:  Icon(Icons.check_circle_outline_outlined,color: ColorsManager.primary),),
        model['status']=='archive'?const SizedBox(): IconButton(
            onPressed:(){
              GymCubit.get(context).updateToDatabase(
                status: 'archive', id: model['id'],
              );
            },
            icon:  Icon(Icons.archive_outlined,color:  ColorsManager.primary)),
      ],
    ),
  ),
);