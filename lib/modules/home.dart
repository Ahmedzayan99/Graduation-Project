import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../shared/cubit/states.dart';
import '../shared/widgets/home_training_item_widget.dart';
import 'dummy/home_dummy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/cubit/cubit.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
       return ConditionalBuilder(
          condition:homeTrainingDummy[0].details.isNotEmpty,
          builder:(context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:  const EdgeInsets.only(right:17.0,left: 17.0 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.only(start:13.0,),
                    height: 40.0,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text("Let's start the plan",
                              style: TextStyle(
                                color:Color.fromRGBO(251, 251, 251, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,

                              )),
                        ),

                        Expanded (
                          flex: 1,
                          child: Container(
                            height: 29.0,
                            width: 20.0,
                            decoration:const BoxDecoration(
                              image:DecorationImage(
                                image:AssetImage(
                                    'assets/images/Vector.png' ),),),
                            child: Column(mainAxisAlignment:MainAxisAlignment.end,
                              children: const [
                                Image(image: AssetImage('assets/images/aaaa.png')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 13.0,),
                  Container(
                    height: 47.0,
                    decoration:BoxDecoration(borderRadius:BorderRadius.circular(70.0),color:const Color.fromRGBO(69, 69, 69, 1),),
                    child: Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:const [
                          Icon(Icons.search,
                            color: Color.fromRGBO(158, 158, 158, 1),
                          ),
                          Text('Search anything',
                              style: TextStyle(
                                color: Color.fromRGBO(158, 158, 158, 1),
                                fontSize: 17.0,
                                fontWeight:FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 19.0,),
                 /* Padding(
                    padding: const EdgeInsets.symmetric( horizontal:9.0),
                    child:Row(
                      children: const [
                        Text("Recommended Training",
                            style: TextStyle(
                              color:Color.fromRGBO(251, 251, 251, 1),
                              fontWeight: FontWeight.bold,
                              fontSize:18.0,


                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,),
                  Column(
                    children: [
                      GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        mainAxisExtent: 370,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 14.0,
                      ),
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children:List.generate(homeTrainingDummy.length,(index){
                          var homeDummyItem =  homeTrainingDummy[index];
                          return HomeTrainingItemWidget(selectTraining: homeDummyItem,);
                        }),)
                    ],
                  ),*/
                  const SizedBox(
                    height:24.0,),
                ],
              ),
            ),
          ) ,
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
 /* */