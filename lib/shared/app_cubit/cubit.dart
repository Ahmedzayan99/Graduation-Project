// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, prefer_if_null_operators, avoid_types_as_parameter_names

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:blackgym/model/plan/exercises_by_plan.dart';
import 'package:blackgym/model/notes/notes.dart';
import 'package:blackgym/model/exercises/all_exercises.dart';
import 'package:blackgym/model/muscles/muscles.dart';
import 'package:blackgym/model/exercises/only_muscle.dart';
import 'package:blackgym/model/plan/plan.dart';
import 'package:blackgym/model/authentication/get_user/user_model.dart';
import 'package:blackgym/modules/exercises/exercises.dart';
import 'package:blackgym/modules/home/home.dart';
import 'package:blackgym/modules/notas/notes_layout.dart';
import 'package:blackgym/modules/settings/settings.dart';
import 'package:blackgym/modules/workouts/workouts.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/network/constants.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:blackgym/shared/styles/iconly_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
class GymCubit extends Cubit<GymStates> {
  GymCubit() : super(GymInitialState());
  get index => null;
  static GymCubit get(context) => BlocProvider.of(context);
  //<<<<<<<<<<<<<<<<<Start the cubit of BottomNavigationBar >>>>>>>>>>>>>>>>>>>>>>
  int current = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const ExercisesScreen(),
    WorkoutsScreen(),
    NotesLayoutScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    if (index == 1) {
      checkInternet();
      getAllMuscles();
    }
    if (index == 2) {
    //  getUserData();
      getPlan(day:'${DateFormat('EEEE').format((todayDateBeforeFormat))}');
      //'${DateFormat('EEEE').format((DateTime.now()))}');
    }
    if (index == 4) {
      getUserData();
    }
    if (index == 3) {
      getNotes();
    }
    current = index;
    emit(GymChangeBottomNavBarState());
  }

  //<<<<<<<<<<<<<<<<<Start the cubit of page Setting >>>>>>>>>>>>>>>>>>>>>>
  bool myProfile = false;

  void changeBottomProfile() {
    myProfile = !myProfile;
    emit(GymChangeProfileState());
  }

  bool ourBranch = false;

  void changeBottomBranch() {
    ourBranch = !ourBranch;
    emit(GymChangeBranchState());
  }

  IconData iconPasswordLogin = IconlyBroken.hide;
  bool isPasswordLogin = true;

  void changePasswordLoginVisible() {
    isPasswordLogin = !isPasswordLogin;
    iconPasswordLogin =
    isPasswordLogin ? IconlyBroken.hide : Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePasswordEditState());
  }
  IconData iconPasswordConfirmLogin = IconlyBroken.hide;
  bool isPasswordConfirmLogin = true;

  void changePasswordConfirmVisible() {
    isPasswordConfirmLogin = !isPasswordConfirmLogin;
    iconPasswordConfirmLogin =
    isPasswordConfirmLogin ? IconlyBroken.hide : Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePasswordConfirmEditState());
  }

  bool isPasswordRegister = true;
  IconData iconPasswordRegister = IconlyBroken.hide;

  bool EvaluateCoach = false;

  void changeBottomEvaluateCoach() {
    EvaluateCoach = !EvaluateCoach;
    emit(GymChangeBranchState());
  }

  bool language = false;

  void changeBottomLanguage() {
    language = !language;
    emit(GymChangeLanguageState());
  }

  bool selectLanguage = true;

  void changeBottomSelectLanguage() {
    selectLanguage = !selectLanguage;
    emit(GymInitialState());
  }

  double heightInitial = 120;

  void updateHeight({
    required double height,
  }) {
    heightInitial = height;
    print(heightInitial);
    emit(UpdateHeightState());
  }

  double weightInitial = 60;

  void updateWeight({
    required double weight,
  }) {
    weightInitial = weight;
    print(weightInitial);
    emit(UpdateWeightState());
  }

  double ageInitial = 21;

  void updateAge({
    required double age,
  }) {
    ageInitial = age;
    print(ageInitial);
    emit(UpdateAgeState());
  }

  double fatPercentageInitial = 5;

  void updateFatPercentaget({
    required double fatPercentage,
  }) {
    fatPercentageInitial = fatPercentage;
    print(fatPercentageInitial);
    emit(UpdateFatPercentageState());
  }

  File? profileImage;
  var picker = ImagePicker();
  void getProfileImage() async {
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('no image selected');
      emit(ProfileImagePickerErrorState());
    }
  }

  Future<void> uploadProfileImage() async {
    emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('ahmed/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateProfileImage(image: value);
        //   updateProfileImage(image: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }


 void updateProfileImage({
    String? image,
  }) {
      DioHelper.postData(url:updateProfile , data: {
        "user_id":userModel!.users!.id,
      "name":userModel!.users!.name,
      "password":'123456789',
      "phone_number":userModel!.users!.phoneNumber,
      "height":userModel!.users!.height,
      "weight":userModel!.users!.weight,
      "age":userModel!.users!.age,
      "fat_percentage":userModel!.users!.fatPercentage,
        "image_url":image,
        "gender":userModel!.users!.gender,
        "membership":'paid',
        "coash_name":userModel!.users!.coashName

      }).then((value) {
      profileImage = null;
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  void updateProfilePassword({
    String? password,
  }) {
    emit(UpdateUserPasswordLoadingState());
    DioHelper.postData(url:updateProfile , data: {
      "user_id":userModel!.users!.id,
      "name":userModel!.users!.name,
      "password":password,
      "phone_number":userModel!.users!.phoneNumber,
      "height":userModel!.users!.height,
      "weight":userModel!.users!.weight,
      "age":userModel!.users!.age,
      "fat_percentage":userModel!.users!.fatPercentage,
      "image_url":userModel!.users!.imageUrl,
      "gender":userModel!.users!.gender,
      "membership":'paid',
      "coash_name":userModel!.users!.coashName

    }).then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserPasswordErrorState());
    });
  }



/*
  void updateUserBady({
    String? height,
    String? age,
    String? fatPercentage,
    String? weight,
  }) async {
    UserModel model = UserModel(
      name: userModel?.name,
      email: userModel?.email,
      phone: userModel?.phone,
      uId: userModel?.uId,
      image: userModel?.image,
      gender: userModel?.gender,
      height: '${ageInitial.round()}',
      age: '${ageInitial.round()}',
      fatPercentage: '${fatPercentageInitial.round()}',
      weight: '${weightInitial.round()}',
    );
    emit(UpdateUserBadyLoadingState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      print("yessssss");
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }
*/
/*

  void updateName({
    required String name,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: userModel?.email,
      phone: userModel?.phone,
      height: userModel?.height,
      image: userModel?.image,
      age: userModel?.age,
      uId: userModel?.uId,
      fatPercentage: userModel?.fatPercentage,
      weight: userModel?.weight,
      gender: userModel?.gender,
    );
    emit(UpdateNameLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      print("yessssss");
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }
*/
/*  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(CacheHelper.getDataIntoShPre(key: "uId"))
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print("Bishooooooo $userModel");
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
      print('ffffffffff' + error.toString());
    });
  }*/
//
  Future<void> logOut() async {
    CacheHelper.removeUserData(key:'token');
  }
  List<String> dropDownButton = [
    'ar',
    'en',
  ];
  String lang = 'en';
  void changeLanguage({required String languageCode}) {
    if (languageCode.isNotEmpty) {
      lang = languageCode;
    } else {
      lang = lang;
    }
    CacheHelper.saveData(key: 'Lang', value: lang).then((value) {
      emit(ChangeAppModeState());
    });
  }
  void confirmPasswordReset() {
    FirebaseAuth.instance
        .confirmPasswordReset(code: '1112', newPassword: '11111111')
        .then((value) {
      print('sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    }).catchError((error) {
      print(
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      print(error.toString());
    });
  }
  //<<<<<<<<<<<<<<<<<Start the cubit of BottomSheet >>>>>>>>>>>>>>>>>>>>>>
  bool isBottomSheet = false;
  IconData iconShow = Icons.add_task;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    iconShow = icon;
    emit(ChangeBottomSheetState());
  }
// Todo:Start database
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

 void createDatabase() {
    print('Start **********************************');
    openDatabase(
      'GymApp.db',
      version: 1,
      onCreate: (database, version) {
        print('DataBase Created ------------------------------------');
        database
            .execute(
            'CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Table Created ====================================');
        }).catchError((error) {
          print('error when ${error.toString()}');
        });
      },
      onOpen: (database) {
        getFromDatabase(database);
        print('DataBase Opened ________________________________________');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }
 // Task? taskList;
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
          'INSERT INTO task (title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print(' insert successfully');
        emit(InsertDatabaseState());
        getFromDatabase(database).then((value) =>
          (value) {
         // taskList = Task.fromMap(value);
        //print('ffffffffffffffffffffffffffffffffffffffffffffff$taskList');

          });
      }).catchError((error) {
        print('when error${error.toString()}');
      });
    });
  }

  Future<void> getFromDatabase(database) async {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM task').then((value) {
      // taskList.add(value);
      value.forEach((element) {
        if (element['status'] == 'new') {
      // taskList = Task.fromMap(element);
          //  keys!.add(element['id']);
          newTasks.add(element);
      //    print(newTasks.toString());
   /*    return Task(
         id: newTasks.first['id'],
         title: newTasks.first['title'],
         date: newTasks.first['date'],
         time: newTasks.first['time'],
         status: newTasks.first['status'],
       );*/
     //  print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww${taskList.toString()}');
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(GetDatabaseState());
    });
  }

  void updateToDatabase({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE task SET status = ? WHERE id = ?', [status, id]).then((value) {
      getFromDatabase(database);
      emit(UpdateDatabaseState());
    });
  }

  void deleteFromDatabase({
    required id,
  }) {
    database.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }


  //TODO : START BISHO\

  var todayDateBeforeFormat = DateTime.now();
  var dateBarStartDay = DateTime.now();
  DatePickerController? today;
  String? date = DateFormat('EEEE,dd MMMM').format((DateTime.now()));

  PlanModel? planlModel;
  Future<void> getPlan(
  {required String? day,}
  ) async {
    emit(GetPlanLoading());
    await DioHelper.getData(url:'$api${CacheHelper.getDataIntoShPre(key:'token')}/$day')
        .then((value) {
      planlModel = PlanModel.fromJson(value.data);
             print('dddddddddddddddd');
          emit(GetPlanSuccess());
      //  }
        }).catchError((error) {
      emit(GetPlanError(error: error.toString()));
      print('ssssssssssssssssssssssss' + error.toString());
    });
  }
  ExercisesModel? onlyMucsleModel;
  Future<void> getOnlyMuscles() async {
    emit(GetOnlyMusclesLoading());
    await DioHelper.getData(url:allExercises)
        .then((value) {
      onlyMucsleModel = ExercisesModel.fromJson(value.data);
      emit(GetOnlyMusclesSuccess());
        })
        .catchError((error) {
      emit(GetOnlyMusclesError(error: error.toString()));
    });
  }

  MusclesModel? musclesModel;
  Future<void> getAllMuscles() async {
    emit(GetAllMusclesLoading());
    await DioHelper.getData(url: muscles)
        .then((value) {
      musclesModel = MusclesModel.fromJson(value.data);
      emit(GetAllMusclesSuccess());
    })
        .catchError((error) {
      emit(GetAllMusclesError(error: error.toString()));
    });
  }



  OnlyMucsleModel? onlyMucsleModel1;
  Future<void> getOnlyMuscles1({
    required int? id,

  } ) async {
    emit(GetOnlyMusclesLoading());
    onlyMucsleModel1==[];
    await DioHelper.getData(url:'${muscleMuscles}$id')
        .then((value) {
      onlyMucsleModel1 = OnlyMucsleModel.fromJson(value.data);
      emit(GetOnlyMusclesSuccess());
    })
        .catchError((error) {
      emit(GetOnlyMusclesError(error: error.toString()));
    });
  }



  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    await DioHelper.getData(url: user.getProfile(id: CacheHelper.getDataIntoShPre(key:'token'))).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!);
      emit(GetUserSuccessState());
    })/*;
    await DioHelper.getData(url: user)
        .then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(GetUserSuccessState());
    })*/
        .catchError((error) {
      emit(GetUserErrorState(error: error.toString()),);
      print(error.toString());
    });
  }


  Future<void> submit({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    await DioHelper.postData(url: register, data: {
      "name": name,
      "email": email,
      "password": password.toString(),
      "phone_number": phoneNumber.toString(),
      "height": 'heightInitial.toString()',
      "weight": 'weightInitial.toString()',
      "age": 'ageInitial.toString()',
      "fat_percentage": 'fatPercentageInitial.toString()',
    }).then((value) {
      print("111111111111");
      print("2222222222222");
    }).catchError((error) {
      print('CreateUserErrorState$error');
    });
  }

/*  Future<void> CreateNotes({
   required String title,
   required String time,
    required String data,
  }) async {
    emit(CreateNotesLoadingState());
    final model = Notes(
      data: data,
      status: 'new',
      time:time ,
      title: title,
        id:'2'
     );
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('2')
        .collection('Note')
        .add(model.toMap())
        .then((value) {
      emit(CreateNotesSuccess());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateNotesError());
    });
  }*/
  Future<void> createNotes(
  {
  required String data,
    required String time,
   // required String status,
    required String title,
}
      ) async {
    emit(CreateNotesLoadingState());
    Notes model = Notes(
      id: '${Random().nextInt(1000)}',
      data: date,
      status: 'now',
      time: time,
      title: title,
    );
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .doc('${model.id}')
        .set(model.toMap())
        .then((value) {
          print(model.id);
      emit(CreateNotesSuccess());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateNotesError());
    });
  }

  List<Notes>? task;
  List<Notes>? taskdane;
  void getNotes (){
    emit(GetNotesLoadingState());
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .snapshots().listen((event) {
          task=[];
          taskdane=[];
            event.docs.forEach((element) {
              if(element.data()['status']=='now') {
                task!.add(Notes.fromJson(element.data()));
              }
              else{
                  taskdane!.add(Notes.fromJson(element.data()));
              }
            });
          emit(GetNotesSuccess());
    });
  }
  void deleteNotes (
     {
  required String id,
}
      ){

    emit(GetNotesLoadingState());
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .doc('${id}')
        .delete()
        .then((value) {
            emit(CreateNotesSuccess());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateNotesError());
    });
  }
  void updateNotes (
      {
        required String data,
        required String time,
        required String id,
        required String title,
      }
      ){
    emit(GetNotesLoadingState());
    Notes model = Notes(
      id: id,
      data: data,
      status: 'done',
      time: time,
      title: title,
    );
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .doc('${id}')
        .update(model.toMap())
        .then((value) {
      emit(CreateNotesSuccess());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateNotesError());
    });
  }
  Future<void> updateRate({
  required int stars,
}
      ) async {
    emit(UpdateRateLoading());
    await DioHelper.postData(
        url: rate,
        data:{
          "user_id":userModel!.users!.id,
          "Coash_id":29,
          "stars":stars,
        }).then((value) {
          emit(UpdateRateSuccess());
    }).catchError((error){
      emit(UpdateRateError(error: error));
    });
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  bool? internet;

  Future<Timer> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
        print('connected');
      }
    } on SocketException catch (_) {
      internet = false;
      print('not connented');
    }
    return Timer(Duration(seconds: 2), () {
      checkInternet();
    });
  }

}

  ////////////////////////////////////////////////////////////////////////////////////////////////////////