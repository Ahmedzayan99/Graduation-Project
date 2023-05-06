/*
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_cubit/states.dart';
import '../styles/colors_manager.dart';
class NEWScreen extends StatelessWidget {
   NEWScreen( {Key? key,
   }) :super(key: key);
  @override
   Widget build(BuildContext context,) {
     return BlocConsumer<GymCubit, GymStates>(
         listener: (context, state) {
         },
         builder: (context, state) {
           var cubit = GymCubit.get(context);
           return ConditionalBuilder(
             condition: state is! GetAllMusclesLoading||state is! GetAllMusclesError,
             builder: (context) => Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   SizedBox(
                     height: 25.0,
                     child: ListView.builder(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context, index) =>
                           Transform.scale(
                             scale: 1.5,
                             child: Checkbox(
                                 value: value,
                                 onChanged: ( value){
                                 } ,activeColor: Colors.blueAccent
                             ),
                           ),
                       itemCount:4,
                     ),
                   ),
                   const SizedBox(height: 15.0,),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Expanded(
                         child: Column(
                           children: [
                             Container(
                               width: 157.0,
                               height: 141.0,
                               decoration: BoxDecoration(
                                 border: Border.all(
                                     color: const Color.fromRGBO(
                                         248, 202, 89, 0.6470588235294118),
                                     width: 1.5,
                                     style: BorderStyle.solid),
                                 borderRadius: BorderRadius.circular(20.0),
                                 image:  DecorationImage(
                                   image: NetworkImage(cubit.PlModel!.data![index].image.toString()),

                                   fit: BoxFit.cover,),
                               ),
                             ),
                             TextButton(onPressed: () {
                               Navigator.pop(context);
                             },
                               child: const Text('Show more',
                                 style: TextStyle(
                                   color: Color.fromRGBO(255, 227, 40, 1),
                                 ),),
                             )
                           ],
                         ),
                       ),
                       const SizedBox(width: 10.0,),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             ListView.separated(
                               shrinkWrap: true,
                               itemBuilder: (context, index) => Container(
                                 height: 30.0,
                                 width: double.infinity,
                                 margin: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
                                 decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
                                 child: InkWell(
                                   onTap:() {
                                   },
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.center ,
                                     children: [
                                       const Padding(
                                         padding: EdgeInsetsDirectional.only(start: 10.0),
                                         child: Text(
                                           'SET 1',
                                           style: TextStyle
                                             (
                                               fontSize: 16,
                                               color: Colors.black,
                                               fontWeight: FontWeight.bold),),
                                       ),
                                     ],
                                   ),
                                 ),

                               ),
                               separatorBuilder:(context, index) => const SizedBox(height: 15.0,),
                               itemCount:4,
                             ),

                           ],
                         ),
                       ),

                     ],
                   ),
                 ],
               ),
             ),
             fallback: (context) => defaultProgressIndicator(),
           );
         });
   }
}

*/
/*
  CircleAvatar(backgroundImage: AssetImage('assets/images/abdominal muscles.png'),radius: 50,),
              SizedBox(height: 20.0,),
              Container(
                height: 20.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemBuilder: (context, index) =>
                      Transform.scale(
                        scale: 1.7,child:
                      Checkbox(value: value, onChanged: ( value){
                        } ,activeColor: Colors.blueAccent
                  ),
                  ) ,
                  separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                  itemCount: 4,
                ),
              ),
                   SizedBox(height: 20.0,),
                   ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    height: 30.0,
                    width: double.infinity,
                    margin: EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
                    child: InkWell(
                      onTap:() {
                        setState(() {
                          value=! value;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center ,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 10.0),
                            child: Text(
                              'SET 1',
                              style: TextStyle
                                (
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),

                  ),
                  separatorBuilder:(context, index) => SizedBox(height: 15.0,),
                  itemCount: 4),






















Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("images/back.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.only(left: 20,top: 100,right: 20),
              children: [
                Container(padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),color: Colors.tealAccent

                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundImage: AssetImage('images/gym.jpg'),radius: 50,),
                          Transform.scale(scale: 1.7,child: Checkbox(value: value, onChanged: ( value){


                          } ,activeColor: Colors.blueAccent
                          ),
                          ),
                          Transform.scale(scale: 1.7,child: Checkbox(value: Value, onChanged: (Value){

                          }),),
                          Transform.scale(scale: 1.7,child: Checkbox(value: _value, onChanged: ( _value){


                          }),)



                        ],),
                      Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(

                          title: Text('SET 1',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                          onTap: (){
                            setState(() {
                              value=! value;
                            });
                          },
                        ),),
                      Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(


                          title: Text('SET 2',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                          onTap: (){
                            setState(() {
                              Value=! Value;
                            });
                          },
                        ),),
                      Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(

                          title: Text('SET 3',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                          onTap: (){
                            setState(() {
                              _value=! _value;
                            });
                          },
                        ),),
                    ],
                  ),)
              ],
            ),
          ],
        ));*/
