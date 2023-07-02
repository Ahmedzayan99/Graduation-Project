
// ignore_for_file: file_names, unnecessary_import, must_be_immutable

import 'dart:io';

import 'package:blackgym/model/notes/notes.dart';
import 'package:blackgym/modules/notas/new_notes.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/global/app_notifications/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/styles/colors_manager.dart';
import '../../shared/widgets/note_builder.dart';
import 'done_notes.dart';
class NotesLayoutScreen extends StatefulWidget {
   NotesLayoutScreen({Key? key}) : super(key: key);

  @override
  State<NotesLayoutScreen> createState() => _NotesLayoutScreenState();
}
class _NotesLayoutScreenState extends State<NotesLayoutScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  var titleController = TextEditingController();
  var timeController =TextEditingController();
  var dateController = TextEditingController();

//_____________start build Widget____________________________________________________________
  @override
  Widget build(BuildContext context)
  {
            return BlocConsumer<GymCubit,GymStates>(
              listener: (context, state) {
              },
              builder: (context, state) {
                return Scaffold(
                  key: scaffoldKey,
                  appBar: AppBar(
                      title: Row(
                        children: [
                          Text(' Notes',),
                          Icon(Icons.sticky_note_2_outlined,color: ColorsManager.primary),
                        ],
                      ),
                      actions: [
                        IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DoneTask(),));
                        },
                          icon:  Icon(Icons.check_circle_outline,color: ColorsManager.primary),),
                      ]),
                  body:GymCubit.get(context).task! !=null?NewNotesScreen():Center(
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
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: ColorsManager.primary,
                    onPressed: () {
                      if (GymCubit.get(context).isBottomSheet ) {
                        if (formKey.currentState!.validate()) {
                          GymCubit.get(context).createNotes(
                              title: titleController.text,
                              time: timeController.text,
                              data: dateController.text,
                          ).then((value) {
                            Navigator.pop(context);
                            titleController.clear();
                            timeController.clear();
                            dateController.clear();
                          });
                        }
                      }
                      else {
                        scaffoldKey.currentState!.showBottomSheet((context) =>Container(
                            padding: const EdgeInsets.all(20.0,),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Title Note';
                                        }
                                        /*else if(value!.length>=40){
                                          return 'No more than 40 characters are allowed';
                                        }*/
                                        return null;
                                      },
                                      controller:titleController,
                                      decoration:   InputDecoration(
                                        hintText: 'Note Title',
                                        hintStyle: TextStyle(color: ColorsManager.black),
                                        suffixIconColor:ColorsManager.primary,
                                        contentPadding: const EdgeInsets.all(8.0),
                                        suffixIcon:IconButton(onPressed: (){},
                                            icon:  Icon(Icons.title,color: ColorsManager.primary,)
                                        ),
                                        filled: false,
                                        border: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
                                        /// Enable Border
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width: 0),
                                        ),

                                        /// Focused Border
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width:0),
                                        ),

                                        /// Error Border
                                        errorBorder:  const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width:0),
                                        ),

                                        /// Focused Error Border
                                        focusedErrorBorder: const OutlineInputBorder(
                                          borderSide:BorderSide(width: 0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0,),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Time Note';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                            .then((value){
                                          timeController.text = value!.format(context).toString();
                                        });
                                      },
                                      controller:timeController,
                                      decoration:   InputDecoration(
                                        hintText: 'Note Time',
                                        hintStyle: TextStyle(color: ColorsManager.black),
                                        suffixIconColor:ColorsManager.primary,
                                        contentPadding: const EdgeInsets.all(8.0),
                                        suffixIcon:IconButton(onPressed: (){},
                                            icon:  Icon(Icons.access_time,color: ColorsManager.primary,)
                                        ),
                                        filled: false,
                                        border: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
                                        /// Enable Border
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width: 0),
                                        ),

                                        /// Focused Border
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width:0),
                                        ),

                                        /// Error Border
                                        errorBorder:  const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width:0),
                                        ),

                                        /// Focused Error Border
                                        focusedErrorBorder: const OutlineInputBorder(
                                          borderSide:BorderSide(width: 0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0,),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Date Note';
                                        }
                                        return null;
                                      },
                                      onTap: ()
                                      {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2025-05-05'),
                                        ).then((value) {
                                          dateController.text=DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                      controller:dateController,
                                      decoration:   InputDecoration(
                                        hintText: 'Note Date',
                                        hintStyle: TextStyle(color: ColorsManager.black),
                                        suffixIconColor:ColorsManager.primary,
                                        contentPadding: const EdgeInsets.all(8.0),
                                        suffixIcon:IconButton(onPressed: (){},
                                            icon:  Icon(Icons.date_range,color: ColorsManager.primary,)
                                        ),
                                        filled: false,
                                        border: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
                                        /// Enable Border
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width: 0),
                                        ),

                                        /// Focused Border
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width:0),
                                        ),

                                        /// Error Border
                                        errorBorder:  const OutlineInputBorder(
                                          borderSide:
                                          BorderSide( width:0),
                                        ),

                                        /// Focused Error Border
                                        focusedErrorBorder: const OutlineInputBorder(
                                          borderSide:BorderSide(width: 0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                           ).closed.then((value) =>
                        {
                          GymCubit.get(context).changeBottomSheetState(
                              isShow:false ,
                              icon: Icons.add_task_sharp)
                        });
                        GymCubit.get(context).changeBottomSheetState(
                          isShow:true ,
                          icon: Icons.add_task_sharp,);
                      }
                    },
                    child: Icon(GymCubit.get(context).iconShow,color: ColorsManager.black),),
                );
              },

            );
          }
      }



/*



// ignore_for_file: file_names, unnecessary_import, must_be_immutable

import 'dart:io';

import 'package:blackgym/model/notes.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/components.dart';
import 'package:blackgym/shared/global/app_notifications/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/styles/colors_manager.dart';
import '../../shared/widgets/note_builder.dart';
import 'done_notes.dart';
class NewTaskScreen extends StatefulWidget {
   NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  var titleController = TextEditingController();

  var timeController =TextEditingController();

  var dateController = TextEditingController();

//_____________start build Widget____________________________________________________________
  @override
  Widget build(BuildContext context)
  {
    //  TodoCubit cubit = BlocProvider.of(context);
    //  var c = TodoCubit.get(context);
    //----------Start the  bloc
    return BlocConsumer<GymCubit,GymStates>(
      listener:(context, state) {
        if(state is InsertDatabaseState){
          Navigator.pop(context);
        }
      } ,
      builder: (context, state) {
        GymCubit cubit = GymCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          // ------appBer -------  .listen((event) {
          //               final tasks = event.docs.map((doc)
          //               { Notes.fromJson(doc.data() as Map<String,dynamic>);
          //               });
          //             });
          //             ----
          appBar: AppBar(
            title: Row(
              children: [
                Text(' Notes',),
            Icon(Icons.sticky_note_2_outlined,color: ColorsManager.primary),
              ],
            ),
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DoneTask(),));
                },
                    icon:  Icon(Icons.check_circle_outline,color: ColorsManager.primary),),
             /*   IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ArchivedTask(),));
                }, icon:  Icon(Icons.archive,color: ColorsManager.primary,)),*/
              ]),
          body: StreamBuilder(
            stream:  FirebaseFirestore.instance
                .collection('Notes')
                .doc('2')
                .collection('Note').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError){
                Text('errror:${snapshot.error}');
                if (snapshot.connectionState == ConnectionState.waiting){
                   showProgressIndicator(context);
                }
              }
              final tasks = snapshot.data!.docs.map((doc)=>
                 Notes.fromJson(doc.data() as Map<String,dynamic>)).toList();

              return ConditionalBuilder(
                condition: state is! GetDatabaseLoadingState,
                builder:(context) {
                  return NotasBuilder(
                      tasks:tasks
                  );
                },
                fallback:(context) => const Center(
                    child: CircularProgressIndicator()
                )
            );
          },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorsManager.primary,
            onPressed: () {
              if (cubit.isBottomSheet ) {
                if (formKey.currentState!.validate()) {
                  /*    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text
                  );*/
                  cubit.CreateNotes(
                      title: titleController.text,
                      time: timeController.text,
                      data: dateController.text
                  ).then((value) {
                    Navigator.pop(context);
                  });
                  /*then((value) {
                    cubit.getFromDatabase(cubit.database).then((value) {
                      Navigator.pop(context);
                      cubit.changeBottomSheetState(
                          isShow:false ,
                          icon: Icons.edit,);
                      cubit.tasks =value;
                      print("is----------------------------------------------------------");
                      print(cubit.tasks);
                    });
                  });*/

                }
              }
              else {
                scaffoldKey.currentState!.showBottomSheet(
                      (context) =>Container(
                    //  color:Colors.grey[300],
                    padding: const EdgeInsets.all(20.0,),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter time task';
                                }
                                return null;
                              },
                              controller:titleController,
                              decoration:   InputDecoration(
                                hintText: 'Task Title',
                                hintStyle: TextStyle(color: ColorsManager.black),
                                suffixIconColor:ColorsManager.primary,
                                contentPadding: const EdgeInsets.all(8.0),
                                suffixIcon:IconButton(onPressed: (){},
                                    icon:  Icon(Icons.title,color: ColorsManager.primary,)
                                ),
                                filled: false,
                                border: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
                                /// Enable Border
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width: 0),
                                ),

                                /// Focused Border
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width:0),
                                ),

                                /// Error Border
                                errorBorder:  const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width:0),
                                ),

                                /// Focused Error Border
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide:BorderSide(width: 0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter time task';
                                }
                                return null;
                              },
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                    .then((value){
                                  timeController.text = value!.format(context).toString();
                                });
                              },
                              controller:timeController,
                              decoration:   InputDecoration(
                                hintText: 'Task Time',
                                hintStyle: TextStyle(color: ColorsManager.black),
                                suffixIconColor:ColorsManager.primary,
                                contentPadding: const EdgeInsets.all(8.0),
                                suffixIcon:IconButton(onPressed: (){},
                                    icon:  Icon(Icons.access_time,color: ColorsManager.primary,)
                                ),
                                filled: false,
                                border: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
                                /// Enable Border
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width: 0),
                                ),

                                /// Focused Border
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width:0),
                                ),

                                /// Error Border
                                errorBorder:  const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width:0),
                                ),

                                /// Focused Error Border
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide:BorderSide(width: 0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter time task';
                                }
                                return null;
                              },
                              onTap: ()
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2025-05-05'),
                                ).then((value) {
                                  dateController.text=DateFormat.yMMMd().format(value!);
                                });
                              },
                              controller:dateController,
                              decoration:   InputDecoration(
                                hintText: 'Task Date',
                                hintStyle: TextStyle(color: ColorsManager.black),
                                suffixIconColor:ColorsManager.primary,
                                contentPadding: const EdgeInsets.all(8.0),
                                suffixIcon:IconButton(onPressed: (){},
                                    icon:  Icon(Icons.date_range,color: ColorsManager.primary,)
                                ),
                                filled: false,
                                border: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
                                /// Enable Border
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width: 0),
                                ),

                                /// Focused Border
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width:0),
                                ),

                                /// Error Border
                                errorBorder:  const OutlineInputBorder(
                                  borderSide:
                                  BorderSide( width:0),
                                ),

                                /// Focused Error Border
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide:BorderSide(width: 0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0,),

                          ],
                        ),
                      ),
                    ),
                  ),
                  elevation: 20.0,
                ).closed.then((value) =>
                {
                  cubit.changeBottomSheetState(
                      isShow:false ,
                      icon: Icons.add_task_sharp)
                });
                cubit.changeBottomSheetState(
                  isShow:true ,
                  icon: Icons.add_task_sharp,);
              }
            },
            child: Icon(cubit.iconShow,color: ColorsManager.black),),
        );
            },
        );
      }
}


/*
show picker of IOS
      showCupertinoModalPopup(context: context,
                                builder:(context) =>CupertinoDatePicker(onDateTimeChanged:(value) {

                              },
                                  mode: CupertinoDatePickerMode.date,
                                backgroundColor: Colors.amberAccent,
                                initialDateTime: DateTime.now(),
                              ),);
 */























show picker of IOS
      showCupertinoModalPopup(context: context,
                                builder:(context) =>CupertinoDatePicker(onDateTimeChanged:(value) {

                              },
                                  mode: CupertinoDatePickerMode.date,
                                backgroundColor: Colors.amberAccent,
                                initialDateTime: DateTime.now(),
                              ),);
 */