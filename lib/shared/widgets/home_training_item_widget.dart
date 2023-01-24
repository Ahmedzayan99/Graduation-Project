import 'package:blackgym/models/home_training_model.dart';
import 'package:blackgym/modules/start_training.dart';
import 'package:blackgym/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTrainingItemWidget extends StatelessWidget {
  final Train selectTraining;
  const HomeTrainingItemWidget({Key? key,
    required this.selectTraining}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> GymCubit(),
      child: SizedBox(
        height: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 275.0,
              height: 182.0,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(248, 202, 89, 1.9),
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(selectTraining.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 11.0,
            ),
            Text(

              selectTraining.lebol,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                color: Color.fromRGBO(251, 251, 251, 1),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            SizedBox(
              height: 99.0,
              child: Text(
                selectTraining.details,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color.fromRGBO(188, 186, 186, 1),
                  fontWeight: FontWeight.w200,
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Container(
              height: 27.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70.0),
                color: const Color.fromRGBO(248, 202, 89, 1),
              ),
              child: MaterialButton(
                onPressed: () {


                Navigator.push(
                    context,
                    MaterialPageRoute(

                      builder: (context) => StartTraining(),
                    ),
                  );
                },
                child: const Text('Start training'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
