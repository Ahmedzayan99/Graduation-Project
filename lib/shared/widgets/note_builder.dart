// ignore_for_file: must_be_immutable, avoid_print

import 'package:blackgym/model/notes/notes.dart';
import 'package:blackgym/modules/notas/note_details.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class NotasBuilder extends StatelessWidget {
 List<Notes> tasks;
  NotasBuilder({
    Key? key,
    required this.tasks,
  }) : super(key: key);
 List<Color> color1=[
   Colors.grey,
   Colors.amber,
   Colors.deepPurple,
 ];
  @override
  Widget build(BuildContext context) {
    return   ListView.separated(
      physics: BouncingScrollPhysics(),
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
    );
  }
}
Widget buildTaskItem(Notes model,context, int index,) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 150.0,
    decoration:BoxDecoration(
        color:ColorsManager.grey,
    borderRadius: BorderRadius.all(Radius.circular(10),),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex:6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                   NoteDetails(title:'${model.title}'),
                                ),);

                          },
                          child: Text('${model.title}',
                            maxLines: 1,
                            style:  TextStyle(
                               overflow: TextOverflow.ellipsis,
                              inherit: true,
                              fontSize: 25.0,
                              color: ColorsManager.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,),
                        child: Chip(
                          backgroundColor: ColorsManager.primary,
                          label:Text(
                            '${model.time}',
                            style: const TextStyle(
                              fontSize:14.0,color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                  model.status=='done'?const SizedBox():IconButton(
                    onPressed:(){
                      GymCubit.get(context).updateNotes(
                        title:'${model.title}',
                        time: '${model.time}',
                        data: '${model.data}',
                        id: '${model.id}',
                      );
                    },
                    icon:  Icon(Icons.check_circle_outline_outlined,color: ColorsManager.white),),
                   IconButton(
                      onPressed:(){
                        GymCubit.get(context).deleteNotes(id:'${model.id}');
                      },
                      icon:  Icon(Icons.delete,color:  Colors.red)),
                ],
                ),

              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${model.data}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0
                ),)

            ],
          ),
        ],
      ),
    ),
  ),
);