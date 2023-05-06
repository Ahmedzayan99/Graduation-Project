
// ignore_for_file: file_names, unnecessary_import, must_be_immutable

import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/styles/colors_manager.dart';
import '../../shared/widgets/note_builder.dart';
import 'archivedTask.dart';
import 'doneTask.dart';
class NewTaskScreen extends StatelessWidget {
   NewTaskScreen({Key? key}) : super(key: key);


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
          // ------appBer -----------
          appBar: AppBar(
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DoneTask(),));
                },
                    icon: const Icon(Icons.cloud_done_rounded)),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ArchivedTask(),));

                },
                    icon: const Icon(Icons.archive)),

              ]),
          body:ConditionalBuilder(
              condition: state is! GetDatabaseLoadingState,
              builder:(context) {
                var tasks =GymCubit.get(context).newTasks;

                return NotasBuilder(
                    tasks:tasks
                );
              },
              fallback:(context) => const Center(
                  child: CircularProgressIndicator()
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheet ) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text
                  );
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
                    color:Colors.grey[300],
                    padding: const EdgeInsets.all(20.0,),
                    child: Form(
                      key: formKey,
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
                          hintStyle: TextStyle(color: ColorsManager.grey),
                          suffixIconColor:ColorsManager.black,
                          contentPadding: const EdgeInsets.all(8.0),
                          suffixIcon:IconButton(onPressed: (){},
                              icon:  Icon(Icons.title,color: ColorsManager.grey,)
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
                              hintStyle: TextStyle(color: ColorsManager.grey),
                              suffixIconColor:ColorsManager.black,
                              contentPadding: const EdgeInsets.all(8.0),
                              suffixIcon:IconButton(onPressed: (){},
                                  icon:  Icon(Icons.access_time,color: ColorsManager.grey,)
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
                              hintStyle: TextStyle(color: ColorsManager.grey),
                              suffixIconColor:ColorsManager.black,
                              contentPadding: const EdgeInsets.all(8.0),
                              suffixIcon:IconButton(onPressed: (){},
                                  icon:  Icon(Icons.date_range,color: ColorsManager.grey,)
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
                  elevation: 20.0,

                ).closed.then((value) =>
                {
                  cubit.changeBottomSheetState(
                      isShow:false ,
                      icon: Icons.edit)
                });
                cubit.changeBottomSheetState(
                  isShow:true ,
                  icon: Icons.note_add,);
              }
            },
            child: Icon(cubit.iconShow),),
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