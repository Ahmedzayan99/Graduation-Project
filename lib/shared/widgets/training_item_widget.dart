 import 'package:blackgym/models/home_training_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/start_training_model.dart';
import '../../modules/details_training.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
class TrainingItemWidget extends StatelessWidget {
  late SelectTrain train;
   TrainingItemWidget({Key? key,
     required this.train,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> GymCubit(),
        child:BlocConsumer<GymCubit,GymStates>(
        listener: (context, state) {},
        builder: (context, state){
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
                  image: AssetImage(train.image),
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
                Text(train.lebol,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: Color.fromRGBO(251, 251, 251, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),
                SizedBox(
                  height: 93.0,
                  child: Text(train.details,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromRGBO(188, 186, 186, 1),
                      fontWeight: FontWeight.w200,
                      fontSize: 12.0,
                    ),),
                ),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => detailsTraining(bigDetails:train,)));
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
    }),
    );
  }
}