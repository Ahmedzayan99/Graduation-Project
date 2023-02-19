import 'package:blackgym/model/chat_model.dart';
import 'package:blackgym/model/user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/logic/home_logic/cubit.dart';
import '../../shared/logic/home_logic/states.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
import '../../shared/styles/string_manager.dart';

class ChatsPersonScreen extends StatelessWidget {
  UserModel? userModel;

  ChatsPersonScreen({Key? key,required this.userModel,}) : super(key: key,);
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        GymCubit.get(context).getMessage(receiverId:'${userModel!.uId}');
        return BlocConsumer<GymCubit,GymStates>(
         listener: (context, state) {
         },
          builder:(context, state) {
            return  Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: const Icon(IconlyBroken.arrow_left_2,color: Colors.black,)),
                title: Row(
                  mainAxisAlignment:MainAxisAlignment.start ,
                  children:  [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage:NetworkImage('${userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${userModel!.name}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
              body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: GymCubit.get(context).messages.length>0,
                builder: (context){
                  return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var messages =GymCubit.get(context).messages[index];
                          if(GymCubit.get(context).userModel!.uId==messages.senderId) {
                            return buildresevar(messages);
                          }else {
                            return buildmassage(messages);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 15.0,),
                        itemCount: GymCubit.get(context).messages.length),
                  );
                },  fallback: (context) =>
                      Center(child:CircularProgressIndicator(color:ColorsManager.primary,)),

                  ),
                  const SizedBox(height: 20.0,),
                   Spacer(),
                  Container(
                    decoration:BoxDecoration(
                      borderRadius:BorderRadius.only(topRight: Radius.circular(15.0)
                          ,bottomRight: Radius.circular(15.0)),
                    ) ,
                   // clipBehavior:Clip.antiAliasWithSaveLayer ,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            //controller:textController,
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:BorderRadius.only(topLeft: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
                              ),
                              /// Focused Border
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:BorderRadius.only(topLeft: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),),
                              /// Focused Error Border
                              ///
                              filled: false,
                              hintStyle: const TextStyle(color: Colors.orange,),
                              prefixIcon:IconButton(onPressed:(){}, icon: const Icon(Icons.photo_camera,color:Colors.black26,),),
                            ),
                          ),
                        ),
                        Container(
                          color:Colors.blue,
                          height: 50.0,
                          width: 50.0,
                          child: MaterialButton(
                            onPressed: (){
                              GymCubit.get(context).sendMessage(
                                dataTime:DateTime.now().toString(),
                                receiverId: '${userModel!.uId}',
                                text:'textController.text',
                              );
                            },
                            minWidth: 1.0,
                            child: const Icon(
                              Icons.send,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            );
          },

            );
          },
        );
      }

  Widget buildmassage(MessageModel message){
    return   Align(
      alignment:AlignmentDirectional.centerStart,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),

            )
        ),
        child:  Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '${message.text}',
            style: TextStyle(
              fontSize: 15.0,

            ),
          ),
        ),
      ),
    );
  }
  Widget buildresevar(MessageModel message){
    return   Align(
      alignment:AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),

            )
        ),
        child:  Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '${message.text}',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
