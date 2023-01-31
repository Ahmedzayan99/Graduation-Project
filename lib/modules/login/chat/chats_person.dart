import 'package:flutter/material.dart';

class ChatsPersonScreen extends StatelessWidget {
  const ChatsPersonScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment:MainAxisAlignment.start ,
          children: const [

            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyBW50HXz_R2LLQhQKsdDh4SsyT7ktZCXL5A&usqp=CAU'),

            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Captain Ahmed' ,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
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
            Align(
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'ازى حضرتك يا كابتن',
                    style: TextStyle(
                      fontSize: 15.0,

                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height:20.0 ,
            ),
            Align(
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'اهلا بيك معاك كابتن احمد',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration:BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,

                ),
                borderRadius:BorderRadius.circular(15.0),
              ) ,
              clipBehavior:Clip.antiAliasWithSaveLayer ,
              child: Row(
                children: [

                  Expanded(
                    child: TextFormField(
                      decoration:  InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 0),
                            borderRadius:  BorderRadius.all(Radius.zero)),

                        /// Focused Border
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color:Colors.black, width:0),
                            borderRadius: BorderRadius.all(Radius.zero)),
                        errorBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.zero)),

                        /// Focused Error Border
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(),
                            borderRadius:BorderRadius.all(Radius.zero)),

                        filled: false,
                        hintText: 'Message',
                        hintStyle: const TextStyle(color: Colors.black,),
                        prefixIcon:IconButton(onPressed:(){}, icon: const Icon(Icons.photo_camera,color:Colors.black26,),),
                      ),
                    ),
                  ),
                  Container(
                    color:Colors.blue,
                    height: 50.0,
                    width: 50.0,
                    child: MaterialButton(
                      onPressed: (){},
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
  }
}
