import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/home_training_model.dart';
import 'dummy/chat_dummy.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              CircleAvatar(
                radius:20.0,
                backgroundImage:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrEKzfqs3C8pG3IVRel5YpYB80O6Etejb44g&usqp=CAU'),

              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Chats',
                style: TextStyle(
                  color: Colors.white,

                ),

              ),
            ],
          ),
        ) ,
      ),
      body:Container(width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration( image:DecorationImage(image: AssetImage("assets/image/61f8424c973e1880ac79ea3f9a2db1d4.png"),fit: BoxFit.fill)),
        child:SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0,),
                    color: Colors.white10,
                  ),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 15.0,
                        height: 40.0,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height:20.0 ,
                ),
                ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index)=>buildChatItem(users[index]),
                  separatorBuilder:(context,index)=>const SizedBox(
                    height: 20.0,
                  ),
                  itemCount: users.length,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChatItem(Model users)=>Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children:  [
          CircleAvatar(
            radius:30.0,
            backgroundImage:NetworkImage(users.photos),

          ),
          const CircleAvatar(radius: 7.0,
            backgroundColor: Colors.green,),
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
  );
  }
