import 'package:blackgym/modules/exercises/details_training.dart';
import 'package:blackgym/shared/app_cubit/cubit.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class planExercises extends StatelessWidget {
   final planModel;
  const planExercises({Key? key,required this.planModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding:  const EdgeInsets.only(top: 10.0,right: 0.0,left: 0.0),
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap:true ,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top:10.0,left: 5.0),
                    child: Column(
                      children: [
                        /*  Row(
                          children: [
                          Expanded(
                          child: cubit.value1 == false
                      //   || acheHelper.getDataIntoShPre(key: "value1") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ),
                            cubit.onlyMucsleModel!.data![index].groups == 2 ||
                                cubit.onlyMucsleModel!.data![index].groups == 3 ||
                                cubit.onlyMucsleModel!.data![index].groups== 4 ?
                          Expanded(
                          child: cubit.value2 == false
                       //   || CacheHelper.getDataIntoShPre(key: "value2") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ):const SizedBox(),
                            cubit.onlyMucsleModel!.data![index].groups == 3 ||
                              cubit.onlyMucsleModel!.data![index].groups == 4?
                          Expanded(
                          child: cubit.value3 == false
                          || CacheHelper.getDataIntoShPre(key: "value3") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ):const SizedBox(),
                            cubit.onlyMucsleModel!.data![index].groups == 4 ?
                          Expanded(
                          child: cubit.value4 == false
                          || CacheHelper.getDataIntoShPre(key: "value4") == false
                          ?
                          const Icon(Icons.check_box_outline_blank,size: 37,):Icon(Icons.check_box,size: 37,
                          color: ColorsManager.primary,
                          ),
                          ):const SizedBox(),
                          ],
                          ),*/
                        //   const SizedBox(height: 15.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        248, 202, 89, 0.6470588235294118),
                                    width: 1.5,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: NetworkImage(planModel.data!.data![0].exercises![index].image.toString()),
                                  fit: BoxFit.cover,),

                              ),
                            ),
                            const SizedBox(width: 10.0,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.0,),
                                  Text(planModel.data!.data![0].exercises![index].name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(251, 251, 251, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),),
                                  SizedBox(height: 5.0,),
                                  SizedBox(
                                    height: 15.0,
                                    child: Text('${planModel.data!.data![0].exercises![index].groups} set x 10-12 reps',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:  TextStyle(
                                        color: ColorsManager.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),),
                                  ),
                                  TextButton(onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (context) => DetailsTraining(
                                      image:planModel.data!.data![index].exercises![index].image.toString() ,
                                      description:planModel.data!.data![index].exercises![index].description.toString() ,
                                      name:planModel.data!.data![index].exercises![index].name.toString(),

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
                            Expanded(
                                child: Chip(
                                    backgroundColor: Colors.cyan,
                                    label: Text('${GymCubit.get(context).onlyMucsleModel!.data![index].muscle !=null?GymCubit.get(context).onlyMucsleModel!.data![index].muscle!.name:'leg'}')))
                          ],
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) {
                    return const SizedBox();},
                  itemCount: planModel.data!.data![0].exercises!.length),
            );
  }
}
