// ignore_for_file: must_be_immutable

import 'package:blackgym/model/user_model.dart';
import 'package:flutter/material.dart';
import '../../modules/chat/chats_person.dart';

class ChatItemWidget extends StatelessWidget {
    UserModel? users;
   ChatItemWidget({Key? key, required this.users}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatsPersonScreen(userModel:users ),));
      },
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children:  [
              CircleAvatar(
                radius:30.0,
                backgroundImage:NetworkImage('${users!.image}'),

              ),
              //    const CircleAvatar(radius: 7.0,
              //    backgroundColor: Colors.green,),
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              '${users!.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,

              ),
            ),
          )
        ],
      ),
    );
  }
}
/** Row(
    children: [
    Expanded(
    child: Text(
    '${users!.email}',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
    color: Colors.white,
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Container(
    width: 10.0,
    height: 10.0,
    decoration: const BoxDecoration(
    color: Colors.cyan,
    shape: BoxShape.circle,
    ),
    ),
    ),
    Text(
    '${users!.height}',
    style: const TextStyle(
    color: Colors.white,
    ),
    )
    ],
    ),**/