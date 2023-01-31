import 'package:flutter/material.dart';
import '../../../shared/widgets/chat_item_widget.dart';
import '../../dummy/chat_dummy.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
            'Chats',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          /**  Container(
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
                  /*    Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
               */

                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),**/
            ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var chatDummy = users[index];
                return ChatItemWidget(users: chatDummy);
              },
              separatorBuilder: (context, index) => SizedBox(height: 20.0,),
              itemCount: users.length,
            ),

          ],
        ),
      ),
    );
  }
}
