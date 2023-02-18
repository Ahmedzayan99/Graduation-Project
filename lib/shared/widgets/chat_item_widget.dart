import 'package:flutter/material.dart';

import '../../data/model/chat_model.dart';
import '../../modules/chat/chats_person.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatModel users;
  const ChatItemWidget({Key? key, required this.users}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatsPersonScreen(),));
      },
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children:  [
              CircleAvatar(
                radius:30.0,
                backgroundImage:NetworkImage(users.photos),

              ),
              //    const CircleAvatar(radius: 7.0,
              //    backgroundColor: Colors.green,),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  users.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        users.message,
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
                      users.data,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
