import 'package:blackgym/model/chat_model.dart';
import 'package:blackgym/model/user_model.dart';
import 'package:blackgym/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/logic/home_logic/cubit.dart';
import '../../shared/logic/home_logic/states.dart';
import '../../shared/styles/colors_manager.dart';
import '../../shared/styles/iconly_broken.dart';
// ignore: must_be_immutable
class ChatsPersonScreen extends StatefulWidget {
  UserModel? userModel;

  ChatsPersonScreen({Key? key,required this.userModel,}) : super(key: key,);

  @override
  State<ChatsPersonScreen> createState() => _ChatsPersonScreenState();
}

class _ChatsPersonScreenState extends State<ChatsPersonScreen> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GymCubit.get(context).getMessage(receiverId:'${widget.userModel?.uId}');
    return Builder(
          builder: (context) {
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
                          backgroundImage:NetworkImage('${widget.userModel!.image}'),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '${widget.userModel!.name}',
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
                        condition: GymCubit.get(context).messages.isNotEmpty,
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
                            separatorBuilder: (context, index) => const SizedBox(height: 15.0,),
                            itemCount: GymCubit.get(context).messages.length),
                      );
                    },
                        fallback: (context) =>
                            defaultProgressIndicator(),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                              controller:textController,
                                decoration:   InputDecoration(
                                  hintText: 'Enter your Message',
                                  hintStyle: TextStyle(color: ColorsManager.grey),
                                  suffixIconColor:ColorsManager.black,
                                  contentPadding: const EdgeInsets.all(8.0),
                                  suffixIcon:IconButton(onPressed: (){},
                                      icon: const Icon(Icons.photo_camera)
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
                            ),
                            MaterialButton(
                              color:Colors.blue,
                              height: 49.0,
                              
                              onPressed: (){
                                GymCubit.get(context).sendMessage(
                                  dataTime:DateTime.now().toString(),
                                  receiverId: '${widget.userModel!.uId}',
                                  text:textController.text,
                                );
                                textController.clear();
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                Icons.send,
                                size: 16.0,
                                color: Colors.white,
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
          }
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
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${message.text}',
            style: const TextStyle(
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
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${message.text}',
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
