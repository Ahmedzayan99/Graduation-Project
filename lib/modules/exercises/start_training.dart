import 'package:blackgym/modules/exercises/details_training.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blackgym/shared/components.dart';


class StartTraining extends StatelessWidget {
   const StartTraining({Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit,GymStates>(
         listener:(context, state) =>{} ,
          builder:(context, state) {
           var cubit = GymCubit.get(context);
             return ConditionalBuilder(
               condition:state is! GetOnlyMusclesLoading,
               builder: (context) => Container(
                 width: double.infinity,
                 height: double.infinity,
                 decoration: const BoxDecoration(
                     image:DecorationImage(
                         image: AssetImage("assets/images/background1.png"),fit: BoxFit.fill) ),
                 child: Scaffold(
                   appBar: AppBar(),
                   body: SingleChildScrollView(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                       child: Column(
                       children: [
                           if(cubit.onlyMucsleModel1!.data!.isNotEmpty)
                             ListView.separated(
                                 shrinkWrap:true,
                                 physics: const NeverScrollableScrollPhysics(),
                                 itemBuilder: (context, index)
                                 {
                                   return Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Expanded(
                                         child: Container(
                                           width: 157.0,
                                           height: 141.0,
                                           decoration: BoxDecoration(
                                             border: Border.all(
                                                 color: const Color.fromRGBO(
                                                     248, 202, 89, 0.6470588235294118),
                                                 width: 1.5,
                                                 style: BorderStyle.solid),
                                             borderRadius: BorderRadius.circular(20.0),
                                             image: DecorationImage(
                                               image: NetworkImage(cubit.onlyMucsleModel1!.data![index].image.toString()),
                                               fit: BoxFit.cover,),

                                           ),
                                         ),
                                       ),
                                       const SizedBox(width: 10.0,),
                                       Expanded(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text(cubit.onlyMucsleModel1!.data![index].name.toString(),
                                               maxLines: 1,
                                               overflow: TextOverflow.fade,
                                               style: const TextStyle(
                                                 color: Color.fromRGBO(251, 251, 251, 1),
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 18,
                                               ),),
                                             SizedBox(
                                               height: 93.0,
                                               child: Text(cubit.onlyMucsleModel1!.data![index].description.toString(),
                                                 maxLines: 4,
                                                 overflow: TextOverflow.ellipsis,
                                                 style: const TextStyle(
                                                   color: Color.fromRGBO(188, 186, 186, 1),
                                                   fontWeight: FontWeight.w200,
                                                   fontSize: 12.0,
                                                 ),),
                                             ),
                                             TextButton(onPressed: () {
                                               Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsTraining(
                                                 image:cubit.onlyMucsleModel!.data![index].image.toString() ,
                                                 description:cubit.onlyMucsleModel!.data![index].description.toString() ,
                                                 name: cubit.onlyMucsleModel!.data![index].name.toString(),

                                               )));
                                             },
                                               child: const Text('Show more',
                                                 style: TextStyle(
                                                   color: Color.fromRGBO(255, 227, 40, 1),
                                                 ),),
                                             )
                                           ],
                                         ),
                                       ),
                                     ],
                                   );
                                 },
                                 separatorBuilder:(context, index) => const SizedBox(height: 10.0,),
                                 itemCount: cubit.onlyMucsleModel1!.data!.length)
                           else
                             Center(
                               child: Icon(Icons.hourglass_empty_rounded,
                                size: 20.0,
                                 color: ColorsManager.primary),
                             ),
                         ],
                       ),
                     ),
                   ),

                 ),
               ),
               fallback: (context) => defaultProgressIndicator(),

             );

    }

    );
  }
}
