import 'package:blackgym/shared/global/app_localization/app_localization.dart';
import 'package:blackgym/shared/logic/home_logic/cubit.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/chat_item_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener: (context, state) {
      },
      builder:(context, state) {
        return Scaffold(
          appBar:AppBar(
            title:  Text(
              "${'chat'.tr(context)}",
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          body:Padding(
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
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var chatDummy =GymCubit.get(context).users[index];
                    return ChatItemWidget(users:chatDummy);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 20.0,),
                  itemCount: GymCubit.get(context).users.length,
                ),

              ],
            ),
          ),
        );},
    );
  }
}
