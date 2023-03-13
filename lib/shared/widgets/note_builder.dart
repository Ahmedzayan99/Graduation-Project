import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class notesbuilder extends StatelessWidget{
  List<Map> tasks;
   notesbuilder({
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
            children: const [
              Icon(Icons.menu,
                  size: 100.0,
                  color: Colors.white),
              Text('لا يوجد مهام,.اضف مهمه جديده',
                style: TextStyle(
                  color: Colors.white,
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
          backgroundColor: Colors.grey[500],
          maxRadius: 40.0,
          child:Text('${model['time']}',
            style: const TextStyle(
              color: Colors.black,
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
                  fontSize:18.0,color: Colors.grey,
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
          icon: const Icon(Icons.check_circle_outline_outlined,color: Colors.grey),),
        model['status']=='archive'?const SizedBox(): IconButton(
            onPressed:(){
              GymCubit.get(context).updateToDatabase(
                status: 'archive', id: model['id'],
              );
            },
            icon: const Icon(Icons.archive_outlined,color: Colors.grey)),
      ],
    ),
  ),
);