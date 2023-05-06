// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, prefer_if_null_operators, avoid_types_as_parameter_names

import 'dart:developer';
import 'dart:io';

import 'package:blackgym/model/muscles/muscles.dart';
import 'package:blackgym/model/muscles/only_muscle.dart';
import 'package:blackgym/model/muscles/plan.dart';
import 'package:blackgym/model/user_model.dart';
import 'package:blackgym/modules/exercises/exercises.dart';
import 'package:blackgym/modules/home/home.dart';
import 'package:blackgym/modules/notas/newTask.dart';
import 'package:blackgym/modules/settings/settings.dart';
import 'package:blackgym/modules/workouts/workouts.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/network/constants.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
class GymCubit extends Cubit<GymStates> {
  GymCubit() : super(GymInitialState());

  static GymCubit get(context) => BlocProvider.of(context);

  //<<<<<<<<<<<<<<<<<Start the cubit of BottomNavigationBar >>>>>>>>>>>>>>>>>>>>>>
  int current = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const ExercisesScreen(),
    WorkoutsScreen(),
    NewTaskScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {

    if (index == 1) {
      getAllMuscles();
    }
  /*  if (index == 2) {
      getPlan();
    }*/
    if (index == 4) {
      getUserData();
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
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
     //   updateProfileImage(image: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }
/*

 void updateProfileImage({
    String? image,
  }) {
    UserModel model = UserModel(
      image: image,
      name: userModel?.name,
      email: userModel?.email,
      phone: userModel?.phone,
      height: userModel?.height,
      age: userModel?.age,
      uId: userModel?.uId,
      fatPercentage: userModel?.fatPercentage,
      weight: userModel?.weight,
      gender: userModel?.gender,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      profileImage = null;
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }
*/

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

  UserModel? userModel;

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
      print('ffffffffff'+error.toString());
    });
  }

//

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeUserData(key: 'uId');
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
  IconData iconShow = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    iconShow = icon;
    emit(ChangeBottomSheetState());
  }
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
        getFromDatabase(database);
      }).catchError((error) {
        print('when error${error.toString()}');
      });
    });
  }

  getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM task').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
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
  PlanModel? planlModel;
  Future<void> getPlan({
    String? id,
     String? day,
}) async {
    emit(GetPlanLoading());
    await DioHelper.getData(url: api.plan(id: 35, day: day))
        .then((value) {
      planlModel = PlanModel.fromJson(value.data);
      print("errorbisho");
      print(planlModel.toString());
      emit(GetPlanSuccess());
    })
        .catchError((error) {
      emit(GetPlanError(error: error.toString()));
      print('ssssssssssssssssssssssss'+error.toString());
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

  OnlyMucsleModel? onlyMucsleModel;

  Future<void> getOnlyMuscles({
  required int? id,
}
      ) async {
    emit(GetOnlyMusclesLoading());
    await DioHelper.getData(url: "$OonlyMuscles/$id")
        .then((value) {
      onlyMucsleModel = OnlyMucsleModel.fromJson(value.data);
      emit(GetOnlyMusclesSuccess());
    })
        .catchError((error) {
      emit(GetOnlyMusclesError(error: error.toString()));
    });
  }
  Future<void> submit({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {

   await DioHelper.postData(url:register , data: {
      "name":name,
      "email":email,
      "password":password.toString(),
      "phone_number":phoneNumber.toString(),
     "height":'heightInitial.toString()',
     "weight":'weightInitial.toString()',
     "age":'ageInitial.toString()',
     "fat_percentage":'fatPercentageInitial.toString()',
    }).then((value) {
      print("111111111111");
      print("2222222222222");

    }).catchError((error){
      print('CreateUserErrorState$error');

    });
  }
  bool value3=false;

  void setValueCheckThree(){
    value3 = !value3;
    log(value3.toString());
    value3 == true ?
        CacheHelper.saveData(key: "value3", value: true):CacheHelper.removeUserData(key: "value3");
      emit(ChangeValueCheckBox());
  }
  bool value1=false;

  void setValueCheckOne(){
    value1 = !value1;
    log(value1.toString());
    value1 == true ?
    CacheHelper.saveData(key: "value1", value: true):CacheHelper.removeUserData(key: "value1");
    emit(ChangeValueCheckBox());
  }
  bool value2=false;

  void setValueCheckTwo(){
    value2 = !value2;
    log(value2.toString());
    value2 == true ?
    CacheHelper.saveData(key: "value2", value: true):CacheHelper.removeUserData(key: "value2");
    emit(ChangeValueCheckBox());
  }
  bool value4=false;

  void setValueCheckFour(){
    value4 = !value4;
    log(value4.toString());
    value4 == true ?
    CacheHelper.saveData(key: "value4", value: true):CacheHelper.removeUserData(key: "value4");
    emit(ChangeValueCheckBox());
  }
}
